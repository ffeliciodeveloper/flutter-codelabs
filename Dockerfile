FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y git curl unzip xz-utils libglu1-mesa openjdk-8-jdk wget

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Setup new user
RUN useradd -ms /bin/bash $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

# Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
# RUN \
#     # [Optional] Add sudo support for the non-root user
#     apt-get install -y sudo \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# Prepare Android directories and system variables
RUN mkdir -p Android/Sdk
ENV ANDROID_SDK_ROOT /home/$USERNAME/Android/Sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Setup Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/Sdk/tools
RUN cd Android/Sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/Sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/$USERNAME/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
