# Network Port Matrix

| Source | Destination | Port | Protocol | Purpose |
|---|---|---:|---|---|
| Internet | Application Load Balancer | 80 | TCP/HTTP | Public website |
| Administrator IP | Bastion | 22 | TCP/SSH | Administration |
| Bastion | Internal VMs | 22 | TCP/SSH | Administration |
| Application Load Balancer | web-1, web-2 | 80 | TCP/HTTP | Web traffic |
| ALB health checks | web-1, web-2 | 80 | TCP/HTTP | Health checks |
| Prometheus | web-1, web-2 | 9100 | TCP/HTTP | Node Exporter metrics |
| Prometheus | Nginx Log Exporter | TBD | TCP/HTTP | Nginx metrics |
| Administrator IP | Grafana | 3000 | TCP/HTTP | Grafana UI |
| Grafana | Prometheus | 9090 | TCP/HTTP | Metrics datasource |
| Filebeat | Elasticsearch | 9200 | TCP/HTTP | Log ingestion |
| Administrator IP | Kibana | 5601 | TCP/HTTP | Kibana UI |
| Kibana | Elasticsearch | 9200 | TCP/HTTP | Log search |

## Security Principle

Default deny where practical.

Only explicitly required communication between components should be allowed.
