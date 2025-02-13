FROM mcr.microsoft.com/playwright:v1.50.1-noble

USER root

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install --no-cache-dir pytest-playwright pytest-html allure-pytest pytest-xdist && \
    playwright install

#Set environment variables for JDK and Allure
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH
ENV ALLURE_HOME /opt/allure
ENV PATH $ALLURE_HOME/bin:$PATH

# Use Tsinghua University mirror for apt (for faster downloads in China)
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirrors.tuna.tsinghua.edu.cn/ubuntu/|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com/ubuntu/|http://mirrors.tuna.tsinghua.edu.cn/ubuntu/|g' /etc/apt/sources.list

# Install OpenJDK 11
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*


# Set the working directory inside the container
WORKDIR /app

# Download and install Allure Commandline using Tsinghua University's mirror
ENV ALLURE_VERSION=2.27.0
RUN curl -o allure-${ALLURE_VERSION}.zip -Ls https://gh-proxy.com/https://github.com/allure-framework/allure2/releases/download/2.27.0/allure-2.27.0.zip \
    && unzip allure-${ALLURE_VERSION}.zip -d /opt/ \
    && ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure \
    && rm -rf allure-${ALLURE_VERSION}.zip

# Verify the installation
RUN allure --version

# Set the entrypoint to allure
CMD ["while true; do sleep 60; done"]
