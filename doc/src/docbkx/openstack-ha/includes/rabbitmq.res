resource rabbitmq {
  device    minor 1;
  disk      "/dev/data/rabbitmq";
  meta-disk internal;
  on node1 {
    address ipv4 10.0.42.100:7701;
  }
  on node2 {
    address ipv4 10.0.42.254:7701;
  }
}
