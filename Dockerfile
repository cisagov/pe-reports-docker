ARG VERSION=unspecified

FROM python:3.9.6-alpine

ARG VERSION

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="mark.feldhousen@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

ARG CISA_UID=421
ENV CISA_HOME="/home/cisa"
ENV ECHO_MESSAGE="Hello World from Dockerfile"

RUN addgroup --system --gid ${CISA_UID} cisa \
  && adduser --system --uid ${CISA_UID} --ingroup cisa cisa

RUN apk --update --no-cache add \
ca-certificates \
openssl \
py-pip

RUN mkdir /usr/src/pe-reports/
RUN git clone https://github.com/cisagov/pe-reports.git /usr/src/pe-reports/
COPY pe-reports/app.py /usr/src/pe-reports/
COPY pe-reports/requirements.txt /usr/src/pe-reports/
WORKDIR /usr/src/pe-reports
EXPOSE 5000
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
