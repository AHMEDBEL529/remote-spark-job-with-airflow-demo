from pyspark.sql import SparkSession

def main():
    # Create a Spark session
    spark = SparkSession.builder.appName("SimpleSparkApp").getOrCreate()

    try:
        # Get the Spark context
        sc = spark.sparkContext

        # Print Spark configuration
        print("Spark Configuration:")
        for (key, value) in sorted(sc.getConf().getAll()):
            print(f"{key}: {value}")

        # Get the number of worker nodes
        num_workers = sc.getConf().get("spark.deploy.retainedExecutors", "1")
        print(f"Number of Worker Nodes: {num_workers}")

        # Your Spark application logic goes here

    finally:
        # Stop the Spark session
        spark.stop()

if __name__ == "__main__":
    main()
