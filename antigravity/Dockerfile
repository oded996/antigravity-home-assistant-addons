ARG BUILD_FROM
FROM ${BUILD_FROM}

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
        procps \
        python3 \
        python3-yaml \
        tmux \
        ttyd \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /

RUN chmod +x \
        /usr/local/bin/agy-console \
        /usr/local/bin/agy-status \
        /usr/local/lib/antigravity/shims/* \
        /etc/s6-overlay/s6-rc.d/*/run \
        /etc/s6-overlay/s6-rc.d/*/finish 2>/dev/null || true
