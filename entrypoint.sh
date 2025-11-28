#!/usr/bin/env bash
set -e

# embedEtcd.yaml 생성 (standalone_embed.sh의 run_embed()와 동일한 내용)
if [ ! -f /milvus/configs/embedEtcd.yaml ]; then
  cat << EOF > /milvus/configs/embedEtcd.yaml
listen-client-urls: http://0.0.0.0:2379
advertise-client-urls: http://0.0.0.0:2379
quota-backend-bytes: 4294967296
auto-compaction-mode: revision
auto-compaction-retention: '1000'
EOF
fi

# user.yaml 생성 (기본은 빈 오버라이드 파일)
if [ ! -f /milvus/configs/user.yaml ]; then
  cat << EOF > /milvus/configs/user.yaml
# Extra config to override default milvus.yaml
EOF
fi

echo "[entrypoint] starting Milvus standalone..."
exec milvus run standalone
