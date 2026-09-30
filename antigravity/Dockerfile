ARG BUILD_FROM
FROM ${BUILD_FROM}
ARG BUILD_ARCH
ARG TTYD_VERSION=1.7.7

# Tools the agent (and you) commonly need when working on a HA config.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        jq \
        less \
        nano \
        openssh-client \
        openssl \
        procps \
        python3 \
        python3-yaml \
        tmux \
        nginx \
    && rm -rf /var/lib/apt/lists/*

# ttyd (ingress setup console) is not packaged in bookworm: use upstream static build.
RUN case "${BUILD_ARCH}" in \
        amd64) ttyd_arch="x86_64" ;; \
        aarch64) ttyd_arch="aarch64" ;; \
        *) echo "Unsupported arch ${BUILD_ARCH}" >&2; exit 1 ;; \
    esac \
    && curl -fsSL -o /usr/local/bin/ttyd \
        "https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${ttyd_arch}" \
    && chmod +x /usr/local/bin/ttyd \
    && /usr/local/bin/ttyd --version

# uv: runs ha-mcp (needs Python >= 3.13, bookworm ships 3.11) with a managed Python.
RUN curl -LsSf https://astral.sh/uv/install.sh \
        | env UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh \
    && uv --version

COPY rootfs /

RUN chmod +x \
        /usr/local/bin/agy-console \
        /usr/local/bin/agy-status \
        /usr/local/lib/antigravity/shims/* \
        /etc/s6-overlay/s6-rc.d/*/run \
        /etc/s6-overlay/s6-rc.d/*/finish 2>/dev/null || true
