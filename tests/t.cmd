go install github.com/foreversmart/ffjson
del ff_ffjson.go
del goser\ff\goser_ffjson.go
del go.stripe\ff\customer_ffjson.go
del types\ff\everything_ffjson.go

go test -v github.com/foreversmart/ffjson/fflib/v1 github.com/foreversmart/ffjson/generator github.com/foreversmart/ffjson/inception && ffjson ff.go && go test -v
ffjson goser/ff/goser.go && go test github.com/foreversmart/ffjson/tests/goser
ffjson go.stripe/ff/customer.go && go test github.com/foreversmart/ffjson/tests/go.stripe
ffjson types/ff/everything.go && go test github.com/foreversmart/ffjson/tests/types


