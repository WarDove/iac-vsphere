#!/bin/bash

%{ for target in route_targets ~}
ip route add ${target} via ${route_gw}
%{ endfor ~}

