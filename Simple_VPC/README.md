# Simple VPC
이것은 가장 간단한 형태의 네트워크 설정입니다.  
이 템플릿을 적용하면 한 개의 [Virtual Private Cloud(VPC)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Introduction.html) 를 생성하고 한 개의 Subnet 을 생성합니다.  
이 VPC 는 외부와의 통신을 할 수 있도록 [Internet Gateway(IGW)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Internet_Gateway.html) 를 가지고 있습니다.  
또한 생성된 Subnet 은 적절한 [Route Table](ttps://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html) 을 이용해 위의 네트워크 설정을 반영하고 있습니다.  
외부와의 통신을 적절히 제한하기 위해 [Network ACL(NACL)](https://docs.aws.amazon.com/ko_kr/AmazonVPC/latest/UserGuide/VPC_ACLs.html) 역시 적용되어 있습니다.  

## Constraints
- [ ] 10.21.0.0/16 [CIDR Block](https://ko.wikipedia.org/wiki/%EC%82%AC%EC%9D%B4%EB%8D%94_(%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%82%B9)) 을 가지는 VPC 가 한 개 생성되어야 한다.
- [ ] 이 VPC 는 IPv6 CIDR Block 또한 가지고 있어야 한다.   
- [ ] 10.21.0.0/24 CIDR Block 을 가지는 Subnet 이 한 개 생성되어야 한다.
- [ ] IGW 가 생성되어 VPC 에 연결되어 있어야 한다.
- [ ] Subnet 에는 Route Table 이 연결되어 있어야 한다.
- [ ] Route Table 은 0.0.0.0/0 연결을 외부로 보낼 수 있어야 한다.
- [ ] NACL 은 다음과 같은 접근제어를 해야 한다.
  - [ ] Ingress 22 TCP from 0.0.0.0/0
  - [ ] Ingress 80, 443 TCP from 0.0.0.0/0
  - [ ] Egress 80, 443 TCP to 0.0.0.0/0
  - [ ] Egress 32768-65535 TCP to 0.0.0.0/0
