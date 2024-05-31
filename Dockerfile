FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

USER root

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install pytest-playwright pytest-html pymsteams && \
    playwright install
