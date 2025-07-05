#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "string.h"

typedef enum {
    EXEC = 0,
    HELP = 1,
    ERROR = 2
} ParseResult;

typedef struct {
    char const* inFile;
    char const* outFile;
    float startSpd;
    float endSpd;
    float delayTime;
    float holdTime;
} Params;

typedef struct {
    char chunkID[4];
    uint32_t chunkSize;
    char format[4];
    char fmtChunkID[4];
    uint32_t fmtChunkSize;
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitDepth;
    char dataChunkID[4];
    uint32_t dataChunkSize;
} WavHeader;

typedef struct {
    uint8_t byte0;
    uint8_t byte1;
    uint8_t byte2;
} LE24BitInt;

ParseResult parseParams(int argc, char const* argv[], Params* params) {
    char const* param = NULL;
    int foundParams = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0) {
            return HELP;
        }

        if (param == NULL) {
            if (argv[i][0] == '-') {
                param = argv[i]+1;
            } else if (i != argc-1) {
                printf("Out file should be last param!");
                return ERROR;
            } else {
                params->outFile = argv[i];
                foundParams++;
            }
        } else {
            if (strcmp(param, "i") == 0) {
                params->inFile = argv[i];
            } else if (strcmp(param, "s") == 0) {
                params->startSpd = atof(argv[i]);
            } else if (strcmp(param, "e") == 0) {
                params->endSpd = atof(argv[i]);
            } else if (strcmp(param, "d") == 0) {
                params->delayTime = atof(argv[i]);
            } else if (strcmp(param, "H") == 0) {
                params->holdTime = atof(argv[i]);
            } else {
                printf("Unrecognized param %s\n", param);
                return ERROR;
            }
            foundParams++;
            param = NULL;
        }
    }
    return foundParams == 6 ? EXEC : ERROR;
}

bool verifyHeader(const WavHeader* header) {
    if (strncmp(header->chunkID, "RIFF", 4) != 0) {
        printf("Invalid RIFF header tag %.4s.\n", header->chunkID);
        return false;
    }

    if (strncmp(header->format, "WAVE", 4) != 0) {
        printf("Format %.4s is not .wav, this program only handles wave files currently.\n", header->format);
        return false;
    }

    if (strncmp(header->fmtChunkID, "fmt ", 4) != 0) {
        printf("First chunk %.4s should be format chunk instead.\n", header->format);
        return false;
    }

    if (header->fmtChunkSize != 16) {
        printf("Chunk size %d should be 16 for PCM.\n", header->fmtChunkSize);
        return false;
    }

    if (header->audioFormat != 1) {
        printf("Audio must be uncompressed.\n");
        return false;
    }

    if (header->bitDepth != 16 && header->bitDepth != 24 && header->bitDepth != 32) {
        printf("Bit depth %d must be one of 16, 24, or 32.\n", header->bitDepth);
        return false;
    }

    return true;
}

int main(int argc, char const *argv[]) {
    Params params;
    ParseResult result = parseParams(argc, argv, &params);

    if (result == HELP) {
        printf("Use the following params:\n\t-i\tin file path\n\t-s\tstart rate\n\t-e\tend rate\n\t-d\tstart delay time\n\t-H\tend hold time\n\tout file path\n");
        return 0;
    } else if (result == ERROR) {
        printf("Some param parse error occured\n");
        return 1;
    }

    FILE* inFile;
    inFile = fopen(params.inFile, "rb");
    if (inFile == NULL) {
        printf("Unable to open file at %s\n", params.inFile);
        return 1;
    }

    WavHeader header;
    fread(&header, sizeof(header), 1, inFile);

    if (verifyHeader(&header)) {
        printf("Verified file header, continuing...\n");
    } else {
        return 1;
    }

    if (header.bitDepth == 24) {
        int32_t* data = malloc(header.dataChunkSize);

        int byteCount = 0;
        LE24BitInt chunk[8];

        while (byteCount+8 < header.dataChunkSize) {
            fread(&chunk, sizeof(LE24BitInt), 8, inFile);
            for (int i = 0; i < 8; i++) {
                int32_t val = chunk[i].byte2 << 24;
                val >>= 8;
                val |= chunk[i].byte0;
                val |= chunk[i].byte1 << 8;
                data[byteCount+i] = val;
            }
            byteCount += 8;
        }

        int remaining = header.dataChunkSize - byteCount;
        if (remaining > 0) {
            fread(&chunk, sizeof(LE24BitInt), remaining, inFile);
            for (int i = 0; i < remaining; i++) {
                int32_t val = chunk[i].byte2 << 24;
                val >>= 8;
                val |= chunk[i].byte0;
                val |= chunk[i].byte1 << 8;
                data[byteCount+i] = val;
            }
        }

        printf("Read all %d bytes...\n", byteCount);

    } else {
        printf("Bit depth %d not yet supported.\n", header.bitDepth);
        return 1;
    }

    fclose(inFile);

    return 0;
}
