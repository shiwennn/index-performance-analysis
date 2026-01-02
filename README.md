# index-performance-analysis
Controlled Oracle Database experiment comparing B-tree vs Bitmap indexes for OLAP-style workloads (aggregation, filtering, joins), analysing query runtime, attribute cardinality effects, and index overhead (storage + build time).

Project Overview
This project evaluates the efficiency of B-tree and Bitmap indexing strategies for large-scale analytical processing in an Oracle Database environment. A controlled star-schema dataset was built and tested using a repeatable workload of aggregation, filtering, and join queries. Performance was measured using query execution time, the impact of attribute cardinality (low vs high), and practical index overhead factors such as index build time and storage requirements.

Experimental Setup (What was tested)
Schema: One fact table and three dimension tables in a star schema (sales_fact, dim_product, dim_region, dim_channel). 
Data generation: Synthetic data populated via PL/SQL using DBMS_RANDOM, with sales_seq generating unique primary keys.
Index conditions:
- No index (baseline)
- B-tree indexing
- Bitmap indexing
Timing & overhead measurement: Query runtime and index creation time were captured using DBMS_UTILITY.get_time, while storage size and index metadata were checked using USER_SEGMENTS and USER_INDEXES.
Visualisation: Results were summarised with Python (pandas, matplotlib) to highlight trends across index types.

Key Findings (High-level)
- Filtering performance improved the most with indexing, where Bitmap indexes produced near-zero filtering times for low-cardinality attributes.
- B-tree indexes were generally more suitable for higher-cardinality attributes and showed stable behaviour across certain tasks.
- Join time stayed largely unchanged across index types in this workload, suggesting that join performance was shaped more by fact table size and optimizer choices than by single-column index selection.

Reproducibility Statement:
To support reproducibility of the reported results, the schema creation scripts, data-generation scripts, benchmark queries (aggregation/filter/join), index creation scripts (B-tree/Bitmap), captured performance outputs, and Python visualisation code are intended to be included in this public repository so that others can rerun the same workload and validate the findings under the same index conditions.
