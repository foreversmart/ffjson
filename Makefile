
all: test install
	@echo "Done"

install:
	go install github.com/foreversmart/ffjson

deps:

fmt:
	go fmt github.com/foreversmart/ffjson/...

cov:
	# TODO: cleanup this make target.
	mkdir -p coverage
	rm -f coverage/*.html
	# gocov test github.com/foreversmart/ffjson/generator | gocov-html > coverage/generator.html
	# gocov test github.com/foreversmart/ffjson/inception | gocov-html > coverage/inception.html
	gocov test github.com/foreversmart/ffjson/fflib/v1 | gocov-html > coverage/fflib.html
	@echo "coverage written"

test-core:
	go test -v github.com/foreversmart/ffjson/fflib/v1 github.com/foreversmart/ffjson/generator github.com/foreversmart/ffjson/inception

test: ffize test-core
	go test -v github.com/foreversmart/ffjson/tests/...

ffize: install
	ffjson tests/ff.go
	ffjson tests/goser/ff/goser.go
	ffjson tests/go.stripe/ff/customer.go
	ffjson tests/types/ff/everything.go

bench: ffize all
	go test -v -benchmem -bench MarshalJSON  github.com/foreversmart/ffjson/tests
	go test -v -benchmem -bench MarshalJSON  github.com/foreversmart/ffjson/tests/goser github.com/foreversmart/ffjson/tests/go.stripe
	go test -v -benchmem -bench UnmarshalJSON  github.com/foreversmart/ffjson/tests/goser github.com/foreversmart/ffjson/tests/go.stripe

clean:
	go clean -i github.com/foreversmart/ffjson/...
	rm -f tests/*/ff/*_ffjson.go tests/*_ffjson.go

.PHONY: deps clean test fmt install all
