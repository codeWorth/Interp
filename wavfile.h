#define IO_CHUNK_SIZE 2048

typedef struct {
    char chunkID[4];
    uint32_t chunkSize;
} ChunkHeader;

typedef struct {
    char format[4];
} RiffChunk;

typedef struct {
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitDepth;
} FmtChunk;

typedef struct {
    ChunkHeader riffHeader;
    RiffChunk riffChunk;

    ChunkHeader fmtHeader;
    FmtChunk fmtChunk;

    ChunkHeader dataHeader;
} WavInfo;

typedef struct {
    float* data;
    int offset;
    int stride;
    int count;
} ChannelView;

/**
 * @brief Write 4 character ID from src into dest.
 * 
 * @param dest Destination char array.
 * @param src Source char array.
 */
void writeID(char* dest, const char* src) {
    for (int i = 0; i < 4; i++) dest[i] = src[i];
}

/**
 * @brief Retrieve the value stored at the given index of the view of the interleaved data.
 * 
 * @param view Channel view to read into.
 * @param i Index.
 * @return float Value at the given index.
 */
inline float v_get(const ChannelView* view, int i) {
    return view->data[view->offset + i * view->stride];
}

/**
 * @brief Store the given value at the given index in interleaved data.
 * 
 * @param view Channel view to write into.
 * @param i Index.
 * @param value Value to write.
 */
inline void v_put(const ChannelView* view, int i, float value) {
    view->data[view->offset + i * view->stride] = value;
}

int getDataEntriesCount(const WavInfo* wavInfo) {
    return wavInfo->dataHeader.chunkSize / (wavInfo->fmtChunk.bitDepth/8);
}

bool verifyWavInfo(const WavInfo* wavInfo) {
    if (strncmp(wavInfo->riffHeader.chunkID, "RIFF", 4) != 0) {
        printf("Invalid RIFF header tag %.4s.\n", wavInfo->riffHeader.chunkID);
        return false;
    }

    if (strncmp(wavInfo->riffChunk.format, "WAVE", 4) != 0) {
        printf("Format %.4s is not .wav, this program only handles wave files currently.\n", wavInfo->riffChunk.format);
        return false;
    }

    if (strncmp(wavInfo->fmtHeader.chunkID, "fmt ", 4) != 0) {
        printf("Format chunk \"%.4s\" should be \"fmt \" instead.\n", wavInfo->fmtHeader.chunkID);
        return false;
    }

    if (wavInfo->fmtHeader.chunkSize != 16) {
        printf("Chunk size %d should be 16 for PCM.\n", wavInfo->fmtHeader.chunkSize);
        return false;
    }

    if (wavInfo->fmtChunk.audioFormat != 1) {
        printf("Audio must be uncompressed.\n");
        return false;
    }

    if (wavInfo->fmtChunk.bitDepth != 16 && wavInfo->fmtChunk.bitDepth != 24 && wavInfo->fmtChunk.bitDepth != 32) {
        printf("Bit depth %d must be one of 16, 24, or 32.\n", wavInfo->fmtChunk.bitDepth);
        return false;
    }

    return true;
}

WavInfo readWavInfo(FILE* inFile) {
    WavInfo wavInfo;

    fread(&wavInfo.riffHeader, sizeof(ChunkHeader), 1, inFile);
    fread(&wavInfo.riffChunk, sizeof(RiffChunk), 1, inFile);

    ChunkHeader header; // seek till fmt chunk
    while (fread(&header, sizeof(ChunkHeader), 1, inFile) > 0) {
        if (strncmp(header.chunkID, "fmt ", 4) == 0) {
            wavInfo.fmtHeader = header;
            break;
        } else {
            fseek(inFile, header.chunkSize, SEEK_CUR);
        }
    }
    fread(&wavInfo.fmtChunk, sizeof(FmtChunk), 1, inFile);

    // seek till data chunk
    while (fread(&header, sizeof(ChunkHeader), 1, inFile) > 0) {
        if (strncmp(header.chunkID, "data", 4) == 0) {
            wavInfo.dataHeader = header;
            break;
        } else {
            fseek(inFile, header.chunkSize, SEEK_CUR);
        }
    }

    return wavInfo;
}

/**
 * @brief Reads the audio data in the given file into the given destination.
 * The current file read position should be at the start of the data.
 * 
 * @param dest Destination array.
 * @param inFile File to read from.
 * @param wavInfo Wave file info from header chunks.
 * @return true Successfully read data.
 * @return false Some error occured.
 */
bool readWavData(float* dest, FILE* inFile, const WavInfo* wavInfo) {
    int dataCount = getDataEntriesCount(wavInfo);

    if (wavInfo->fmtChunk.bitDepth == 32) {

        int32_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < dataCount) {
            int readCount = min(IO_CHUNK_SIZE, dataCount - i);
            fread(chunk, sizeof(int32_t), readCount, inFile);
            for (int j = 0; j < readCount; j++) dest[i+j] = chunk[j];
            i += readCount;
        }

        printf("Read all %d values...\n", dataCount);

    } else if (wavInfo->fmtChunk.bitDepth == 24) {

        int8_t chunk[IO_CHUNK_SIZE/4*3];
        int bI = 0;
        int bCount = dataCount*3;
        while (bI < bCount) {
            int readSize = min(IO_CHUNK_SIZE/4*3, bCount - bI);
            fread(chunk, sizeof(uint8_t), readSize, inFile);

            for (int j = 0; j < readSize; j += 3) {
                int32_t result = chunk[j+2] << 16; // setting the highest byte first also sets the sign bits
                result |= (chunk[j+1] << 8) & 0xFF00;
                result |= chunk[j] & 0xFF;

                dest[(bI + j)/3] = result;
            }
            
            bI += readSize;
        }

        printf("Read all %d values...\n", dataCount);

    } else if (wavInfo->fmtChunk.bitDepth == 16) {
        
        int16_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < dataCount) {
            int readCount = min(IO_CHUNK_SIZE, dataCount - i);
            fread(chunk, sizeof(int16_t), readCount, inFile);
            for (int j = 0; j < readCount; j++) dest[i+j] = chunk[j];
            i += readCount;
        }

        printf("Read all %d values...\n", dataCount);

    } else {
        printf("Bit depth %d not supported.\n", wavInfo->fmtChunk.bitDepth);
    }

    return true;
}

void writeHeader(FmtChunk fmtChunk, int dataEntriesCount, FILE* outFile) {
    ChunkHeader dataHeader;
    writeID(dataHeader.chunkID, "data");
    dataHeader.chunkSize = dataEntriesCount * (fmtChunk.bitDepth/8);

    ChunkHeader fmtHeader;
    writeID(fmtHeader.chunkID, "fmt ");
    fmtHeader.chunkSize = 16;

    ChunkHeader riffHeader;
    writeID(riffHeader.chunkID, "RIFF");
    riffHeader.chunkSize = 36 + fmtHeader.chunkSize + dataHeader.chunkSize;
    RiffChunk riffChunk;
    writeID(riffChunk.format, "WAVE");

    fwrite(&riffHeader, sizeof(ChunkHeader), 1, outFile);
    fwrite(&riffChunk, sizeof(RiffChunk), 1, outFile);

    fwrite(&fmtHeader, sizeof(ChunkHeader), 1, outFile);
    fwrite(&fmtChunk, sizeof(FmtChunk), 1, outFile);

    fwrite(&dataHeader, sizeof(ChunkHeader), 1, outFile);
}

bool writeWavfile(const char* outPath, const WavInfo* wavInfo, const float* data, int count) {
    FILE* outFile;
    // Check if file exists and confirm overwrite with user
    outFile = fopen(outPath, "rb");
    if (outFile != NULL) {
        printf("File %s already exists! Overwrite (Y/N)?\t", outPath);
        while (true) {
            char resp[5];
            fgets(resp, sizeof(resp), stdin);
            if (resp[0] == 'Y') {
                fclose(outFile);
                break;
            } else if (resp[0] == 'N') {
                printf("Aborting.\n");
                return false;
            } else {
                printf("Unrecognized response. Overwrite (Y/N)?\t");
            }
        }
    }

    outFile = fopen(outPath, "wb");

    writeHeader(wavInfo->fmtChunk, count, outFile);

    if (wavInfo->fmtChunk.bitDepth == 32) {

        int32_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < count) {
            int writeCount = min(IO_CHUNK_SIZE, count - i);
            for (int j = 0; j < writeCount; j++) chunk[j] = data[i+j];
            fwrite(chunk, sizeof(int32_t), writeCount, outFile);
            i += writeCount;
        }

    } else if (wavInfo->fmtChunk.bitDepth == 24) {
        
        uint8_t chunk[IO_CHUNK_SIZE/4*3];
        int bI = 0;
        int bCount = count*3;
        while (bI < bCount) {
            int writeSize = min(IO_CHUNK_SIZE/4*3, bCount - bI);

            for (int j = 0; j < writeSize; j += 3) {
                int32_t value = data[(bI + j)/3];
                
                chunk[j] = value & 0xFF;
                chunk[j+1] = (value >> 8) & 0xFF;
                chunk[j+2] = (value >> 16) & 0xFF; 
            }
            
            fwrite(chunk, sizeof(uint8_t), writeSize, outFile);
            bI += writeSize;
        }

    } else if (wavInfo->fmtChunk.bitDepth == 16) {

        int16_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < count) {
            int writeCount = min(IO_CHUNK_SIZE, count - i);
            for (int j = 0; j < writeCount; j++) chunk[j] = data[i+j];
            fwrite(chunk, sizeof(int16_t), writeCount, outFile);
            i += writeCount;
        }

    } else {
        printf("Cannot write %d bit depth!\n", wavInfo->fmtChunk.bitDepth);
        return false;
    }

    fclose(outFile);
    return true;
}
