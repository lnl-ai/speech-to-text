FROM python:3.10-slim

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    ffmpeg \
    portaudio19-dev \
    procps \
    curl \
    telnet \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 拷贝项目文件
COPY . .

# 安装 Python 依赖
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# 下载 whisper 模型（可选：也可以在运行时通过挂载模型目录）
# RUN python3 -c "from faster_whisper import WhisperModel; WhisperModel('small')"

# 设置默认启动端口（如 Web 服务监听在 8080）
EXPOSE 8080

# 启动应用（你可以根据实际入口模块调整这里）
CMD ["python3", "-m", "speech_to_text"]
