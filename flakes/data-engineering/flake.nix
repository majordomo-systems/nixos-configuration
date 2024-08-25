{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
  {
    self,
    nixpkgs,
    systems,
  }:
  let
    forEachSystem =
      f: nixpkgs.lib.genAttrs (import systems) (system: f {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
  in
  {
    devShells = forEachSystem (
      { pkgs }:
      {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            vscode
            python3
            hd5
          ];

          # VSCode extension installation
          shellHook = ''
            mkdir -p .vscode/extensions
            code --install-extension catppuccin.catppuccin-vsc --force
            # Add more extensions here as needed
          '';
        };
      }
    );
  };
}

# Apache Spark: A powerful tool for distributed data processing.
# Apache Kafka: For building real-time streaming data pipelines and applications.
# Airflow: A workflow management system for automating ETL processes.
# Pandas: Essential for data manipulation and analysis in Python.
# Jupyter Notebook: An interactive computing environment for data science.
# Dask: For parallel computing and handling larger-than-memory datasets.
# Scikit-learn: For machine learning tasks.
# NumPy: Fundamental package for scientific computing with Python.
# PostgreSQL/MySQL: Database systems for storing and querying structured data.
# ClickHouse: A fast open-source columnar database management system for analytics.
# Apache Flink: Stream-processing framework for real-time data processing.
# TensorFlow/PyTorch: If you're also doing deep learning alongside your data engineering tasks.
# AWS CLI/GCP CLI/Azure CLI: For interacting with cloud services, if you're dealing with cloud-based data.
# dbt (Data Build Tool): For transforming data in your warehouse.
# Docker: To containerize applications and run them in isolated environments, useful for managing complex data workflows.
# Kubernetes: For orchestrating containerized applications, especially useful in managing large-scale data pipelines.
# Redash: An open-source tool for querying databases and visualizing the results.
# Elasticsearch: A search and analytics engine, great for log and event data analysis.
# Apache Nifi: A powerful tool for automating the flow of data between systems.
# Presto (Trino): A distributed SQL query engine for big data.
# Apache Cassandra: A highly scalable NoSQL database for handling large amounts of data across multiple servers.
# DataGrip: A database IDE for working with multiple databases.
# Tableau: For data visualization, especially useful for creating dashboards.
# Metabase: An open-source business intelligence tool that allows you to ask questions about your data without writing SQL.
# # Neo4J:
# Cypher Shell: A command-line tool for interacting with Neo4j using its Cypher query language.
# Neo4j Desktop: A local development environment for Neo4j, which includes a graphical interface for managing databases.
# Neo4j Browser: A graphical user interface for exploring your data graphically, running queries, and visualizing the results.
# APOC (Awesome Procedures on Cypher): A collection of procedures and functions that extend the capabilities of Cypher.
# Graph Data Science Library: For running advanced graph algorithms on your data within Neo4j.

# Snowflake
# Hadoop