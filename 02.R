# 라이브러리 설치
# Data Frame을 위한 전처리, 조작하기에 쉽고 빠르게 처리해주는 패키지
# dplyr
install.packages("dplyr") # 컴퓨터에 영구 설치
library(dplyr) # python의 import와 같다, 필요할 때마다 써야 됨.
a = 1
a
# 화살표 기호 < / Alt + -
b <- 2
b

k <- a + 3
k

# 여러개의 값 할당
# 함수 c()를 통해서 벡터를 생성할 수 있고,
#   :, ,를 활용해서 연속된 데이터를 표현할 수 있음.

a <- c(11,22,33,44)
b <- c("a","b","c","d")
a
b

# list
li1 <- list(x=1,c('cat','dog'),z=sum)
li1

li2 <- list(aa=a,bb=b)
li2

# data frame : 열의 묶음으로 list 만들기
mydata = as.data.frame(li2)
mydata

DF <- data.frame(c1 = c(1,2,3,4,5),c2=c('ㄱ','ㄴ','ㄷ','ㄹ','ㅁ'))
DF

# $으로 변수를 선택
DF
DF$c1
DF$c2

# sum()
sum(a)

# paste() : 나열된 원소들을 이어붙여서 하나의 결과값으로 내보내는 함수
paste(2,4,7,8)
paste('I am','a','Ironman')
paste('1','2','3','4')
length(paste(2,4,6,8))

# rep : 반복
paste(rep('a',7))

# sep : seperate
paste(1,2,3,4,5,sep='-')

# A~Z까지 알파벳 하나하나 나타내주는 내장형 함수
LETTERS
f <- LETTERS

# 반복문 / 조건문
for (i in f){
  if (i == "W"){
    print('W 였던 것')
  } else {
    print(i)
  }
}

# R에서는 인덱스가 1부터 시작함.(0부터가 아님!)
f[8]  # 8 번째 값
f[2:5]  # 2~5 번째 값
f[-1] # 1번쨰값 빼고 나머지 전부
f[c(1,3,5)] # 1,3,5 번째 값

# range(1,11,2) -> 1~10 2씩 증가. seq로 대체 가능.
f[seq(1,10,2)]

myData <- data.frame(x=c(1,3,5,7,9),y=c(2,4,6,8,10))
myData

# 1행 전부
myData[,1]

# 1열 전부
myData[1,]

# 3,5행 > 2열 빼고 > 출력 (3,5 행의 1열만 출력)
myData[c(3,5),-2]

# 1~10 까지의정수
vt <- c(1:10)
vt

# str(객체) : 데이터 구조 확인
str(vt)

# as : 변수의 데이터 타입을 ~ 로 취급하겠다
vt1 <- as.integer(vt)
str(vt1)
vt2 <- as.numeric(vt)
str(vt2)

# integer : 정수만 저장 가능.
# numeric : integer를 포함한 모든 수를 저장 가능(실수도.)


# summary(변수) : 변수의 구성요소를 요약
#   숫자인 경우 :
#     최소, 최대, 중간, 평균 값,
#     1st Qu. / 3rd Qu.
summary(vt2)

#   문자인 경우 :
#     class를 보여주고, 데이터가 총 몇 개인지를 보여줌.
vt3 <- as.character(vt)
str(vt3)
summary(vt3)


# is : 변수가 ~~ 가 맞는지 아닌지 판단해줌.(논리연산)
is.integer(vt3)
is.character(vt3)


# CSV 파일 불러오기
bike <-  read.csv("C:/Users/sdedu/Desktop/Dev/R/csv/exams.csv")
bike

install.packages("data.table")
library(data.table)
exam2 <- fread("C:/Users/sdedu/Desktop/Dev/R/csv/exams.csv")
exam2


# tidyverse :
#   다양한 패키지를 포함하고 있는 메타 패키지
#   이 패키지를 다 다룰 수 있게 된다면 > 중급 R 데이터 분석가 수준
install.packages("tidyverse")
library(tidyverse)

# 상위에 있는 10개 데이터 > 디테일하게.
tibble(exam2)

# 파이프 연산자(%>%) / Ctrl + Shift + m
#   html : table > tr > td
#   pipe operator : table %>% tr %>% td 같은 형식.
exam2 %>% tibble()

exam2 %>% head()
exam2 %>% View()
exam2 %>% names()

names(exam2)[2:4]

nrow(exam2) # 행(row)의 갯수 >
ncol(exam2) # 열(col)의 갯수
dim(exam2) # 행과 열 모두