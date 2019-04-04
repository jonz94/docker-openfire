all: build

build:
	@docker build --tag=jonz94/openfire .

release: build
	@docker build --tag=jonz94/openfire:$(shell cat VERSION) .
