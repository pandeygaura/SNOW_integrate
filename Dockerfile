# -----------------------------------------------------
# 1. Base Image
# -----------------------------------------------------
FROM python:3.10-slim

# -----------------------------------------------------
# 2. Install system dependencies
#    - tesseract OCR engine
#    - poppler-utils (for pdf2image)
#    - libgl (for pillow + pdf2image)
# -----------------------------------------------------

    
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    libgl1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------
# 3. Set work directory
# -----------------------------------------------------
WORKDIR /app

# -----------------------------------------------------
# 4. Copy requirements and install dependencies
# -----------------------------------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------------------------------
# 5. Copy your entire FastAPI project
# -----------------------------------------------------
COPY . .

# -----------------------------------------------------
# 6. Expose FastAPI port
# -----------------------------------------------------
EXPOSE 8000

# -----------------------------------------------------
# 7. Start the server
# -----------------------------------------------------
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
