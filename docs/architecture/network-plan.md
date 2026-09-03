# Network Architecture

## VPC

Name:

`devops-practice-vpc`

## Availability Zones

- `ru-central1-a`
- `ru-central1-b`

Web servers are distributed between two availability zones.

## Subnets

| Name | CIDR | Zone | Type |
|---|---|---|---|
| public-a | 10.10.10.0/24 | ru-central1-a | Public |
| private-a | 10.10.20.0/24 | ru-central1-a | Private |
| public-b | 10.10.30.0/24 | ru-central1-b | Public |
| private-b | 10.10.40.0/24 | ru-central1-b | Private |

## Resources

| Resource | Zone | Subnet | Public IP | Purpose |
|---|---|---|---|---|
| bastion | ru-central1-a | public-a | Yes | SSH access |
| grafana | ru-central1-a | public-a | Yes | Monitoring UI |
| kibana | ru-central1-a | public-a | Yes | Logs UI |
| web-1 | ru-central1-a | private-a | No | Nginx web server |
| prometheus | ru-central1-a | private-a | No | Metrics collection |
| elasticsearch | ru-central1-a | private-a | No | Logs storage |
| web-2 | ru-central1-b | private-b | No | Nginx web server |
| Application Load Balancer | multi-zone | public | Yes | Public entry point |

## Traffic Flow

Internet -> Application Load Balancer -> web-1 / web-2

Administrator -> Bastion -> private hosts

Prometheus -> exporters on web servers

Filebeat -> Elasticsearch

Grafana -> Prometheus

Kibana -> Elasticsearch

## Important

Private infrastructure services must not accept direct connections from the Internet.

Security Groups will allow only explicitly required traffic.
