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
            ########################################################################################
            ########################################################################################         # Python
            ########################################################################################
            ########################################################################################
            python3
            jupyterlab # Jupyter Notebook: An interactive computing environment for data science.

            # Python Packages
            (python.withPackages (ps: with ps;
            [
              # Testing
              pytest

              # Data Science Tools
              numpy # NumPy: Fundamental package for scientific computing with Python.
              pandas # Pandas: Essential for data manipulation and analysis in Python.
              matplotlib # MatPlotLib: For data visualization with Python.
            ]))
            ########################################################################################
            ########################################################################################
            # Data Storage & Management
            # Tools for storing, querying, and managing data efficiently.
            ########################################################################################
            ########################################################################################
            postgresql # PostgreSQL/MySQL: Database systems for storing and querying structured data.

            # Supabase
            supabase-cli

            # MongoDB
            mongodb
            mongodb-tools
            mongodb-compass

            # Apache Cassandra
            cassandra # Apache Cassandra: A highly scalable NoSQL database for handling large amounts of data across multiple servers.

            # Neo4j
            neo4j # Neo4j: A powerful graph database designed to efficiently manage and query complex, connected data using a flexible property graph model. 
            neo4j-desktop # Neo4j Desktop: A local development environment for Neo4j, which includes a graphical interface for managing databases.

            # Snowflake
            # Snowflake: Cloud data warehouse for scalable storage and analytics.
            ########################################################################################
            ########################################################################################
            # Data Processing & Engineering
            # Tools for processing, transforming, and managing the flow of data.
            ########################################################################################
            ########################################################################################
            # Apache Spark: Distributed data processing.
            # Apache Kafka: Real-time streaming data pipelines and applications.
            # Airflow: Workflow management for automating ETL processes.
            # Dask: Parallel computing and larger-than-memory datasets.
            # Apache Flink: Real-time stream processing.
            # dbt (Data Build Tool): Data transformations in your data warehouse.
            # Apache Nifi: Automating the flow of data between systems.
            # Presto (Trino): Distributed SQL query engine for big data.
            ########################################################################################
            ########################################################################################
            # Data Analytics & Visualization
            # Tools for analyzing and visualizing data to derive insights.
            ########################################################################################
            ########################################################################################         # Scikit-learn: Machine learning tasks.
            # TensorFlow/PyTorch: Deep learning frameworks.
            # Redash: Querying databases and visualizing results.
            # Tableau: Data visualization and dashboards.
            # Metabase: Open-source business intelligence for exploring data.
            # Graph Data Science Library: Advanced graph algorithms and analytics in Neo4j.
            ########################################################################################
            ########################################################################################
            # Development Environments
            ########################################################################################
            ########################################################################################
            # vscode # Visual Studio Code: A lightweight, extensible, and cross-platform IDE by Microsoft.
            # jetbrains.datagrip # DataGrip: Database IDE for working with multiple databases.
            # jetbrains.goland # GoLand: Go IDE from JetBrains.
            # jetbrains.phpstorm # PHPStorm: PHP IDE from Jetbrains.
            # jetbrains.rider # Ridedr: .NET IDE from JetBrains.
            # jetbrains.ruby-mine # Ruby Mine: Ruby IDE from Jetbrains.
          ];

          # VSCode extension installation
          # shellHook = ''
          #   mkdir -p .vscode/extensions
          #   code --install-extension catppuccin.catppuccin-vsc --force
          #   # Add more extensions here as needed
          # '';
        };
      }
    );
  };
}
