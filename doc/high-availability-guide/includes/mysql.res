resource mysql {
  device    minor 0;
  disk      "/dev/data/mysql";
  meta-disk internal;
  on node1 {
    address ipv4 10.0.42.100:7700;
  }
  on node2 {
    address ipv4 10.0.42.254:7700;
  }
}
