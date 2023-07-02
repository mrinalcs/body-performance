bodyPerformance <- read.csv("C:/Users/Mrinal/Downloads/bodyPerformance.csv")
data=bodyPerformance

#Visualising Data

num_cols <- unlist(lapply(data, is.numeric))         # Identify numeric columns
num_cols
data_num <- data[ , num_cols]                        # Subset numeric columns of data
data_num
colnames(data_num)=c('Age','Height (cm)','Weight (kg)','Body fat(%)','Diastolic','Systolic','Grip force','Sit and bend foreward(cm)','Sit up counts','Broad jump(cm)')        # Changing column names
boxplot(data_num,col = factor(data_num$age),main='Boxplot')     # Boxplot of numerical columns


#descriptive
summary(data$age,data$height_cm)


hist(data$age,main='',xlab = 'Age',col = "lightblue",border = "red",breaks = 20)
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)

# count no of male & femalae
male_count <- sum(data$gender == "M")
female_count <- sum(data$gender == "F")

bar_data <- data.frame(
  Gender = c("Male", "Female"),
  Count = c(male_count, female_count)
)
barplot(bar_data$Count, names.arg = bar_data$Gender, col = c("blue", "pink"), main = "", xlab = "Gender", ylab = "Frequency")
legend("topright", legend = c("Male", "Female"), fill = c("blue", "pink"))



hist(data$height_cm,main='Histogram on Height',xlab = 'Height',col = "lightblue",border = "red",breaks = 20)
hist(data$weight_kg,main='Histogram on Weight',xlab = 'Weight',col = "lightblue",border = "red",breaks = 20)
hist(data$body.fat_.,main='Histogram on Body fat',xlab = 'Body fat',col = "lightblue",border = "red",breaks = 20)
hist(data$diastolic,main='Histogram on Diastolic',xlab = 'Diastolic',col = "lightblue",border = "red",breaks = 20)
hist(data$systolic,main='Histogram on Systolic',xlab = 'Systolic',col = "lightblue",border = "red",breaks = 20)
hist(data$gripForce,main='Histogram on gripForce',xlab = 'gripForce',col = "lightblue",border = "red",breaks = 20)
hist(data$sit.and.bend.forward_cm,main='Histogram on sit.and.bend.forward',xlab = 'sit.and.bend.forward',col = "lightblue",border = "red",breaks = 20)
hist(data$sit.ups.counts,main='Histogram on Sit ups counts',xlab = 'sit.ups.counts',col = "lightblue",border = "red",breaks = 20)
hist(data$broad.jump_cm,main='Histogram on broad.jump',xlab = 'broad.jump',col = "lightblue",border = "red",breaks = 20)

## Age vs Height cm
hist(data$age,data$height_cm)
hist(data$age, main = "Age vs Height", xlab = "Age", ylab = "Frequency", col = "lightblue", border = "black")
hist(data$height, col = "lightgreen", border = "black", add = TRUE, breaks = seq(150, 200, by = 100))




## correlation matrix

library(ggplot2)
library(ggcorrplot)

# Reading the data
q=data(USArrests)

# Computing correlation matrix
correlation_matrix <- round(cor(data_num),2)

# Computing correlation matrix with p-values
corrp.mat <- cor_pmat(USArrests)

# Adding the correlation coefficient
ggcorrplot(correlation_matrix, hc.order =TRUE, 
           type ="lower", lab =TRUE)

# Body fat vs gender
# Separate data for male and female
# Separate data for male and female
male_data <- data[data$gender == "M", ]
female_data <- data[data$gender == "F", ]


# Calculate average fat percentage for male and female
mean(data$body.fat_.)
max(data$body.fat_.)
min(data$body.fat_.)

mean(male_data$body.fat_.)
mean(female_data$body.fat_.)

hist(female_data$body.fat_., col = c("blue", "red", "gray", "green"))
hist(male_data$body.fat_.)



# gripForce 
hist(data$gripForce, col = c("blue", "red", "gray", "green"),breaks = 30)

# sit.and.bend.forward_cm
hist(data$sit.and.bend.forward_cm, col = c("blue", "red", "gray", "green"),breaks = 50)


# sit.ups.counts
hist(data$sit.ups.counts, col = c("blue", "red", "gray", "green"),breaks = 30)

# broad.jump_cm
hist(data$broad.jump_cm, col = c("blue", "red", "gray", "green"),breaks = 20)


# Groupping ABCD
A_count <- sum(data$class == "A")
B_count <- sum(data$class == "B")
C_count <- sum(data$class == "C")
D_count <- sum(data$class == "D")
x <- c(A_count,B_count,C_count,D_count)
labels <- c("A", "B", "C", "D")
pie(x,labels)

# Classify ABCD group
class_A_data <- data[data$class == "A", ]
class_B_data <- data[data$class == "B", ]
class_C_data <- data[data$class == "C", ]
class_D_data <- data[data$class == "D", ]

# Summary of numerical values
summary(data_num)
View()
boxplot(data$systolic)
x=data$systolic
# get mean and Standard deviation
mean = mean(x)
std = sd(x)

# get threshold values for outliers
Tmin = mean-(3*std)
Tmax = mean+(3*std)
# find outlier
x[which(x < Tmin | x > Tmax)]
# remove outlier
z=x[which(x > Tmin & x < Tmax)]
boxplot(z)
boxplot(data$age)

# Test
### Shaprio wiki

shapiro.test(male_data$body.fat_.)
shapiro.test(female_data$body.fat_.)

x=male_data$body.fat_.
y=female_data$body.fat_.  
t.test(x,y)                  #T-test








# Combine data into a data frame
one_way_anova_data <- list(Male = x, Female = y)

Data <- data.frame(
  Y=c(x,y),
  Site =factor(rep(c("M", "F"), times=c(length(x), length(y))))
)


fm1 <- aov(Y~Site, data=Data)
anova(fm1)



##
# Load necessary libraries for correlation analysis
library(stats)
# Extract relevant columns
weight_kg <- data$weight_kg
height_cm <- data$height_cm
systolic_bp <- data$systolic

# Convert height from cm to m
height_m <- height_cm / 100

# Calculate BMI
bmi <- weight_kg / (height_m * height_m)

# Conduct correlation analysis
correlation <- cor(bmi, systolic_bp)

# Perform hypothesis test for correlation coefficient
correlation_p_value <- cor.test(bmi, systolic_bp)$p.value

##

# Extract relevant columns
situps_counts <- data$sit.ups.counts
fitness_class <- data$class

# Conduct ANOVA
anova_result <- aov(situps_counts ~ fitness_class, data=data)

# Perform post-hoc Tukey's test for multiple comparisons
posthoc_result <- TukeyHSD(anova_result)

# Output results
cat("ANOVA Results:\n")
print(summary(anova_result))
cat("Post-hoc Tukey's Test Results:\n")
print(posthoc_result)