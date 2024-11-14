FROM alpine:3.20.3

ARG USER=user

ENV PATH="/nix/var/nix/profiles/default/bin:$PATH"
ENV HOME=/home/$USER

RUN apk --no-cache add \
	bash \
	curl \
	shadow \
	xz

RUN mkdir -p $HOME
WORKDIR $HOME

COPY get_nix.sh /usr/local
RUN chmod +x /usr/local/get_nix.sh && bash /usr/local/get_nix.sh
