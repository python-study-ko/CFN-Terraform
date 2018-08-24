# VPC with Bastion
이것은 [AWS 3-tier Architecture](https://slideplayer.com/slide/9251465/) 의 기본 구성이 되는 3-tier 네트워크 구조와 외부에서 내부 네트워크로 접근할 수 있는 통로인 [Bastion Host](https://en.wikipedia.org/wiki/Bastion_host)를 구성합니다.  
이 템플릿을 적용하면 1개의 [Virtual Private Cloud(VPC)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Introduction.html) 를 생성하고 [Internet Gateway(IGW)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Internet_Gateway.html) 를 생성해 VPC 에 연결합니다.  
또한 두 개의 AZ 에 각각 Public/Private/Internal Subnet 을 생성해 총 여섯 개의 Subnet 을 생성합니다.  
각각의 Subnet 에는 적절한 [Route Table](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html) 이 적용되며, 또한 접근을 제어할 수 있는 [Network ACL(NACL)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_ACLs.html) 이 생성되어 적용됩니다.  
마지막으로 Public Subnet 중 한 곳에 외부-내부 네트워크 통로가 되는 Bastion Host EC2 Instance 가 생성되어 적절한 [Security Group(SG)](https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/using-network-security.html) 이 적용됩니다.

## Constraints
- [ ] `10.21.0.0/16` [CIDR Block](https://ko.wikipedia.org/wiki/%EC%82%AC%EC%9D%B4%EB%8D%94_(%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%82%B9)) 을 가지는 VPC 를 생성하는가?  
- [ ] IGW 가 생성되어 VPC 에 적용되는가?  
- [ ] 총 6개의 Subnet 을 두 개의 AZ 에 나누어 생성하는가?  
  - [ ] Public Subnet 은 `10.21.0.0/24`, `10.21.1.0/24` CIDR Block 을 가져야 한다.  
  - [ ] Private Subnet 은 `10.21.10.0/24`, `10.21.11.0/24` CIDR Block 을 가져야 한다.  
  - [ ] Internal Subnet 은 `10.21.20.0/24`, `10.21.21.0/24` CIDR Block 을 가져야 한다.  
- [ ] AZ 당 한 개씩의 [NAT Gateway](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/vpc-nat-gateway.html) 가 생성되어 Public Subnet 에 적용되는가?  
- [ ] 6개의 Subnet 들은 적절한 Route Table 의 적용을 받는가?  
  - [ ] Public Subnet 은 0.0.0.0/0 요청이 IGW 를 타고 외부로 나갈 수 있어야 한다.  
  - [ ] Private Subnet 은 NAT Gateway 를 타고 외부와 통신할 수 있어야 한다.  
  - [ ] Internal Subnet 은 외부와의 연결통로가 없어야 한다.  
- [ ] 6개의 Subnet 들에는 적절한 NACL 룰이 적용되어 있는가?
  - [ ] Public Subnet 은 Ingress/Egress 모두 All TCP 0.0.0.0/0 이 허용되어 있어야 한다.
  - [ ] Private Subnet 은 다음 조건을 만족해야 한다.  
    - [ ] Ingress 80, 443 TCP from 0.0.0.0/0  
    - [ ] Ingress 1024-65535 TCP from NAT GW(0.0.0.0/0)  
    - [ ] Ingress 22 TCP from Public Subnet  
    - [ ] Egress 1024-65535 TCP to 0.0.0.0/0  
    - [ ] Egress 5432, 3306 TCP to Internal Subnet  
  - [ ] Internal Subnet 은 다음 조건을 만족해야 한다.
    - [ ] Ingress 5432, 3306 TCP from Private Subnet
    - [ ] Egress 32768-65535 TCP to Private Subnet
- [ ] Public Subnet 안에 Ubuntu 16.04 Bastion Host EC2 Instance 가 생성되어 있는가?  
- [ ] Bastion Host 는 0.0.0.0/0 으로부터의 SSH Inbound 접속만을 허용해야 한다.  
- [ ] Bastion Host 에 접속이 가능한가?
- [ ] Bastion Host 에서 `$ sudo apt update` 명령이 작동하는가?
