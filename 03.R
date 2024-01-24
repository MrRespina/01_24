library(data.table)
library(tidyverse)
library(dplyr)

# data 불러오기
exam <-fread("C:/Users/sdedu/Desktop/Dev/R/csv/exams.csv")
exam

# 관측치 첫 6개
head(exam)

# 관측치 끝 6개
tail(exam)

# 관측치 끝 3개(n으로 지정)
tail(exam,n=3)

# 스프레드시트 형식으로 확인
View(exam)

# 특정 위치의 변수이름 확인
names(exam)[6:8]

# 변수명 바꾸기
names(exam)[3:5] = c('p','l','t')
names(exam)[3:5]

# 간단한 변수별 요약
summary(exam)


# 총합 / 변수명에 공백이 들어갈 때, ``안에 넣어서 처리
sum(exam$`math score`)

# 평균
mean(exam$`math score`)

# 데이터 갯수
length(exam$gender)


# select() : 변수(열) 추출하기

exam %>% select(gender,'reading score',8) %>% head()





insurance <- fread("C:/Users/sdedu/Desktop/Dev/R/csv/insurance2.csv")
insurance

View(insurance)

# 3,6,7 열 조회
# insurance[,c(3,6,7)]
insurance %>% select(3,6,7)

# 2~8 열 조회
# insurance[,2:8]
insurance %>% select(2:8)

# smoker,bmi 내용만 조회
insurance %>% select(smoker,bmi)

# smoker, bmi 제외하고 조회
insurance %>% select(-smoker,-bmi)

# 1, 2열 빼고 나머지 조회
insurance %>% select(-c(1,2))

# 3열이랑 region 빼고 조회
insurance %>% select(-3,-region)

# age, sex, bmi, charges 열 내용 조회
insurance %>% select(age,sex,bmi,charges)
insurance %>% select(age:bmi,charges)
insurance %>% select(1:3,charges)




# select()에서 사용할 수 있는 함수
# () : 모든 변수 선택
# last_col() : 마지막에 있는 변수 열을 선택
# starts_with(값) : 변수 이름이 ~로 시작하는 변수를 선택
# ends_with(값) : 변수 이름이 ~로 끝나는 변수를 선택
# contains(값) : 이름이 ~이 들어있는 변수를 선택



# c로 시작하는 변수의 내용 조회
insurance %>% select(starts_with('c'))

# n으로 끝나는 변수의 내용을 조회
insurance %>% select(ends_with('n'))

# s가 포함된 변수의 내용을 조회
insurance %>% select(contains('s'))



# ! : 논리 부정(나열된 열의 여집합)
# - 연산자 (차집합)

# 1,2,4 열 변수를 제외한 나머지 출력
insurance %>% select(-c(1,2,4))
insurance %>% select(!c(1,2,4))


# 특정 타입의 변수만 뽑아올 수 있음 : where()
insurance %>% select(where(is.numeric)) # 데이터 타입이 숫자
exam %>%  select(where(is.character))

View(exam)

# filter()
# exam에서 성별이 남자인 사람의 정보의 처음 6개
exam %>% filter(gender == 'male') %>% head()

# 성별이 여자, c그룹에 속하는 사람의 정보의 마지막 6개
exam %>% filter(gender == 'female') %>% filter(`race/ethnicity` == 'group C') %>% tail()

# summarise()
#   평균,빈도, ... 기본적인 통계 수치를 요약하고 싶을 때
exam %>% summarise(max(`math score`),n=n()) # n() : 빈도 수

exam %>% summarise(min(`math score`))

exam %>% summarise(mean(`math score`))


View(exam)
# exam의 읽기 시험점수 최대 값
# exam의 쓰기 시험점수의 최소 값
# exam의 읽기 시험점수의 평균 값
# exam의 쓰기 시험점수의 평균 값
# 하나의 결과로 출력

exam %>% summarise(max(`reading score`),min(`writing score`),mean(`reading score`),mean(`writing score`))

# group_by() : 그룹화
exam %>% group_by(gender) %>% summarise(min(`writing score`),mean(`reading score`),mean(`writing score`))


# insurance 데이터
# 흡연 여부로 묶어서
# bmi의 최대 값, age의 최소 값, charges의 평균, bmi의 중앙 값을 하나의 결과로 출력
# 중앙값은 평균값이 아니다. 50% 분위의 값을 구함. / median() 함수
View(insurance)

insurance %>% group_by(smoker) %>%  summarise(max(bmi),min(age),mean(charges),median(bmi))

# 여러 열을 대상으로 같은 작업을 해야하는 경우 : across()
# 모든 숫자형 변수의 평균값을 계산
insurance %>%  summarise(across(where(is.numeric),mean))

# 변수명이 b로 시작하는 변수의 중앙 값
insurance %>%  summarise(across(starts_with('b'),median))

# 변수명이 age, charges인 변수의 평균 값
insurance %>%  summarise(across(c(age,charges),mean))

# 변수명이 age인 변수의 평균 값과 중앙 값
insurance %>% summarise(across(age,c(mean,median)))

                                              