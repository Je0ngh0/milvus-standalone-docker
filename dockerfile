# Milvus 공식 이미지를 베이스로 사용
FROM milvusdb/milvus:v2.6.4

# Milvus 설정/데이터 디렉토리 생성
RUN mkdir -p /milvus/configs \
    && mkdir -p /var/lib/milvus/etcd \
    && mkdir -p /var/lib/milvus/data

# 기본 환경 변수 (RunPod에서 덮어써도 됨)
ENV ETCD_USE_EMBED=true \
    ETCD_DATA_DIR=/var/lib/milvus/etcd \
    ETCD_CONFIG_PATH=/milvus/configs/embedEtcd.yaml \
    COMMON_STORAGETYPE=local \
    DEPLOY_MODE=STANDALONE

# Milvus가 사용하는 포트들
EXPOSE 19530 9091 2379

# Healthcheck는 Docker 레벨에서 사용 (RunPod는 자체 헬스체크를 안 써도 됨)
HEALTHCHECK --interval=30s --timeout=20s --retries=3 \
    CMD curl -f http://localhost:9091/healthz || exit 1

# 엔트리포인트 스크립트 추가
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
