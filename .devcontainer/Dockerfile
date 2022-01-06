FROM node:16-alpine

ENV pwsh_dir=/opt/powershell

# Install latest PowerShell
# https://docs.microsoft.com/en-us/powershell/scripting/install/install-alpine
RUN \
    apk add --no-cache \
      ca-certificates \
      icu-libs \
      krb5-libs \
      less \
      libgcc \
      libintl \
      libssl1.1 \
      libstdc++ \
      ncurses-terminfo-base \
      tzdata \
      userspace-rcu \
      zlib && \
    apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
      lttng-ust && \
    apk add --no-cache --virtual .build-deps \
      jq && \
    mkdir -pv "${pwsh_dir}" && \
    wget -qO - 'https://api.github.com/repos/powershell/powershell/releases/latest' | \
    jq -r '.assets[] | .browser_download_url | match("https://.+?/powershell-\\d+\\.\\d+\\.\\d+-linux-alpine-x64\\.tar\\.gz") | .string' | \
    xargs -n 1 wget -qO - | \
    tar -C "${pwsh_dir}" -zxvf - && \
    chmod +x "${pwsh_dir}/pwsh" && \
    ln -s "${pwsh_dir}/pwsh" /usr/bin/pwsh && \
    apk del .build-deps

USER node

CMD [ "pwsh" ]