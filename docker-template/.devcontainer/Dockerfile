# syntax=docker/dockerfile:1

#############################
# Base (共通レイヤ)
#############################
FROM ubuntu:22.04 AS base
ENV DEBIAN_FRONTEND=noninteractive

# 必須パッケージ（zsh / tmux / fzf / git / curl / sudo など）
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git zsh tmux fzf sudo locales tini \
 && rm -rf /var/lib/apt/lists/*

# ロケール（任意：英語UTF-8）
RUN sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen || true \
 && locale-gen || true
ENV LANG=en_US.UTF-8

# 非rootユーザー
ARG USER=app
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} ${USER} \
 && useradd  -m -u ${UID} -g ${GID} -s /usr/bin/zsh ${USER} \
 && usermod  -aG sudo ${USER} \
 && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-${USER} \
 && chmod 440 /etc/sudoers.d/90-${USER}

USER ${USER}
WORKDIR /app
ENV SHELL=/usr/bin/zsh

#############################
# Production (軽量ランタイム)
#############################
FROM base AS prod
# アプリの実行に必要な成果物だけをコピー（例）
# COPY --chown=app:app ./app /app

# 健康チェック例（アプリに合わせて調整）
# HEALTHCHECK --interval=30s --timeout=3s CMD curl -fsS http://localhost:8080/health || exit 1

ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["zsh", "-lc", "echo 'Put your app start command here' && sleep infinity"]

#############################
# Development (開発用)
#############################
FROM base AS dev
# 開発は /workspace を作業ディレクトリに
WORKDIR /workspace

# デフォルトは zsh で入る
CMD ["zsh"]