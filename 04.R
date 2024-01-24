library(tidyverse)
library(dplyr)
library(data.table)

exam <-fread("C:/Users/sdedu/Desktop/Dev/R/csv/exams.csv")
exam

# data의 빈도를 나타내는 / 조사하는 함수
# table(), n(), count()

# table() : data의 종류별 갯수가 몇 개인지 파악
# table(DataFramke이름$변수명)

table(exam$`race/ethnicity`)

# n() : dplyr 패키지 안에 있는 함수
# group_by() 함수와 연결되어있는 summarise() 함수 내부에 포함
# table()과는 다르게 세로로 출력
# dataframe이름 %>% group_by(변수명) %>% summarise(표시할 변수명=n())
exam %>%  group_by(`race/ethnicity`) %>% summarise(n=n())

# count() : dplyr 패키지 안에 있는 함수
# count(dataframe명, 변수명)
count(exam,`race/ethnicity`)



# mean vs median
# 중앙값(median) : data들의 중심이 되는 위치를 가리키는 값, 대표값이라고도 부름
# 대부분은 평균으로 계산하지만, 경우에 따라서는 중앙값이 더 정확할 때가 있다.
#   > 데이터가 너무 크거나, 너무 작거나 하는 극단적인 값이 많은 경우
#   > 데이터가 한 쪽으로 치우쳐져있는 경우

# 그룹별로 인원이 몇 명 있는지, 읽기 시험점수의 평균값, 중앙값 출력
exam %>% group_by(`race/ethnicity`) %>% summarise(n=n(),mean(`reading score`),median(`reading score`))



# slice() : index에 의한 행 선택
# 특정한 행을 선택하거나, 제거 가능
# 양수(+) : 해당 행 선택
# 음수(-) : 해당 행 제거

# 5~10 번째 행 
exam %>% slice(5:10)

# 1m01 ~ 1000 번째 행 제거
exam %>% slice(-(101:1000))

# 성별,그룹으로 묶어서 6~10번째 > 수학점수 최대값, 읽기점수 최소값, 쓰기점수 평균값
exam %>%group_by(`gender`,`race/ethnicity`) %>% slice(6:10) %>% summarise(max(`math score`),min(`reading score`),mean(`writing score`))

# 마지막 행만 보고싶다 > n()함수
exam %>% slice(n())

# slice_head() : dataframe의 처음
# slice_tail() : dataframe의 마지막
# 행의 갯수 지정 : n=갯수
# 행의 비율 지정 : prop=비율
exam %>% slice_head(n=5)
exam %>% slice_head(prop=0.25)

# slice_simple() : 랜덤으로 행 선택
# n,prop 통해서 갯수,비율 정하기 가능.
exam %>% slice_sample(n=5)
exam %>% slice_sample(prop=0.25)

# slice_max() : 특정 변수가 가장 클 때
# slice_min() : 특정 변수가 가장 작을 때
# dataframe을 특정 변수로 정렬한 후에 위에서부터 행을 선택
exam %>% slice_max(`math score`,n=10)
exam %>% slice_min(`writing score`,prop=0.01)



# arrange() : 특정 변수를 기준으로 행을 재배열
# 기본값은 오름차순
exam %>% arrange(gender)

# 쓰기시험 오름차순, 쓰기시험 점수 같으면 > 읽기점수 내림차순 정렬
exam %>% arrange(`writing score`,desc(`reading score`))

# 성별, 교육등급을 그룹화해서 > 수학 점수 평균값 지표 > 내림차순으로 정렬
View(exam)
exam %>% group_by(`gender`,`parental level of education`) %>% summarise(mean = mean(`math score`)) %>% arrange(desc(mean))



exams <- exam %>% select(`math score`,`reading score`,`writing score`)
head(exams,10)

# distinct() : 중복없는 유일한 값 추출

exams %>% distinct(`math score`)

# .kepp_all : 지정한 열 뿐만 아니라, 모든 열을 보여줌.
# 모든 열을 유지해서 0,그렇지 않으면 지정한 열만 출력
exams %>% head(12) %>% distinct(`writing score`,.keep_all=T)



# ! : NOT, & : AND, | : OR

View(exam)
# exam 에서 성별이 여자이면서, 쓰기점수가 100점인 사람들의 정보
exam %>% filter(gender == 'female' & `writing score` == 100)

# 성별이 남자이면서, 그룹이 C인 사람들 정보를 출력
exam %>% filter(gender == 'male' & `race/ethnicity` == 'group C')



# ggplot2 > 그래프 형으로 표현하기 위해 사용하는 library
library(ggplot2)

# aes(aesthetic)은 그래프의 미적 부분을 지정하는 속성
# 아래 상태로 실행ㄹ하면, 축이랑 바탕만 그려짐!
# 실제 그래프는 이어서 그래프를 그리는 함수를 추가해야함.
ggplot(data=exam,aes(x=`math score`,y=`reading score`,color=gender))

# 산점도
exam %>% ggplot(aes(x=`math score`,y=`reading score`,color=gender)) +
  # +로 ggplot과 geom_point()를 연결함.
  geom_point() + # Scatter, point > 점 그래프
  scale_color_brewer(palette = 'Set1')
  # scale_color_manual은 손수 색을 정함
  # scale_color_grey는 색을 흑백으로 시각화
  # scale_color_brewer는 누군가가 이미 만들어놓은 palette라는 자료로 값과 색을 대응시키는 방법

  # 색상조합 참고
  RColorBrewer::display.brewer.all()

# 선 그래프
exam %>% ggplot(aes(x=`math score`,y=`reading score`,color=gender)) +
  geom_line() + # line > 선 그래프
  scale_color_brewer(palette = 'Set1')

# 막대 그래프
exam %>% ggplot(aes(gender)) + geom_bar(fill='orange')

exam %>% group_by(gender) %>% summarise(n=n(),m=mean(`math score`)) %>% ggplot(aes(gender,m)) +
  geom_col(fill='royalblue')

# geom_col() : 이미 요약이 되어있는 데이터를 y 축에 넣어서 그래프를 만들 때 사용함.
exam %>% group_by(gender,`race/ethnicity`) %>% summarise(n=n(),m=mean(`reading score`)) %>% ggplot(aes(gender,m,fill=`race/ethnicity`)) +
  geom_col(position = 'dodge')
  # position = 'dodge' : 복수의 데이터를 독립적인 막대 그래프에 표현할 때 사용.
  # 사용하지 않는다면, 하나의 그래프에 뭉쳐서 나타남.

# 상자 그래프 (boxplot)
exam %>% ggplot(aes(`race/ethnicity`,`math score`)) + geom_boxplot()

exam %>% ggplot(aes(`race/ethnicity`,`math score`,fill=gender)) + geom_boxplot() + coord_flip()
# coord_flip() : 가로/세로 반전 옵션


# 열지도 (heatmap)
exam %>% group_by(`race/ethnicity`,`parental level of education`) %>% summarise(n=n(),r=mean(`reading score`)) %>% 
  ggplot(aes(`race/ethnicity`,`parental level of education`,fill=n)) + scale_fill_gradient(low='yellow',high='red') +
  geom_tile()
