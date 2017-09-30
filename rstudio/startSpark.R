print('Now connecting to Spark for you.') 
 
spark_link <- system('cat /home/ec2-user/spark-ec2/cluster-url', intern=TRUE)

.libPaths(c(.libPaths(), '/home/ec2-user/spark/R/lib')) 
Sys.setenv(SPARK_HOME = '/home/ec2-user/spark') 
Sys.setenv(PATH = paste(Sys.getenv(c('PATH')), '/home/ec2-user/spark/bin', sep=':')) 
library(SparkR) 

sc <- sparkR.init(spark_link) 
sqlContext <- sparkRSQL.init(sc) 

print('Spark Context available as \"sc\". \\n')
print('Spark SQL Context available as \"sqlContext\". \\n')