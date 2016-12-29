
all: proto

proto: proto/login.proto
	protoc --descriptor_set_out proto/login.pb proto/login.proto
