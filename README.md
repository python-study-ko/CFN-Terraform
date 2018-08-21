# CFN-Terraform
Compare of AWS CloudFormation and Terraform

## What is this?
이 레포는 [AWS CloudFormation](https://aws.amazon.com/ko/cloudformation/) 과 [Terraform](https://www.terraform.io/) 을 공부하고 비교하기 위해 생성되었습니다.  
완전히 동일한 기능을 하는 네트워크 구조/서비스 구성을 두 개의 템플릿으로 만들어 각자의 특성과 장단점을 비교하고, 이렇게 만들어진 템플릿은 실제 서비스에 적용하기 위한 기초로 사용됩니다.


## How to Use?
각각의 폴더는 하나의 구성이 됩니다.  
각각의 폴더 안에는 개별적으로 무엇을 만들고자 하는지, 어떤 것들이 포함되어 있는지 등을 작성한 `README.md` 파일이 존재해야 하며, 이 둘을 구현한 `CFN yml`, `Terraform tf` 파일이 존재합니다.  
필요에 따라 여러 개의 파일이 필요한 경우 `CFN` or `Terraform` 이라는 이름의 서브폴더를 생성해 사용할 수 있습니다.  
변경사항을 commit 할 경우에는 가능하면 하나의 완성된 결과물이 하나의 commit 이 될 수 있도록 [squash](https://git-scm.com/book/ko/v1/Git-%EB%8F%84%EA%B5%AC-%ED%9E%88%EC%8A%A4%ED%86%A0%EB%A6%AC-%EB%8B%A8%EC%9E%A5%ED%95%98%EA%B8%B0#%EC%BB%A4%EB%B0%8B-%ED%95%A9%EC%B9%98%EA%B8%B0) 해서 push 하는 것을 추천합니다.  
구성의 단계를 보여주는 것이 도움이 되거나, 특별히 변경사항을 기록하는 것이 의미가 있는 경우에는 commit 을 나누도록 합니다.  
commit 타이틀은 `[구성 이름]::[CFN/Terraform]::[commit title/message]` 형태로 적도록 하고, 변경사항이 많은 경우 [커밋 메세지를 여러 줄로 생성](http://yonomi.tistory.com/177)해 커밋 본문에 상세한 변경사항을 적도록 합니다.

## WARNING!!
CloudFormation Stack 을 생성하면 사용한 리소스에 따라 비용이 청구될 수 있습니다.  
따라서 실 서비스가 아닌 테스트 용도라면 Stack 이 의도대로 생성되는 것을 확인한 후 꼭 삭제해야 의도치 않은 비용 발생을 막을 수 있습니다.  
