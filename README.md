# Inventories Management Batch Processing MuleSoft Application

This MuleSoft application processes inventory files and manages data synchronization between systems. It handles input CSV files, transforms them to JSON, validates records, and performs batch processing to manage inventory data.

## Table of Contents

1. [Overview](#overview)
2. [Flows](#flows)
3. [Batch Processing](#batch-processing)
4. [Error Handling](#error-handling)
5. [Scheduler](#scheduler)
6. [Configurations](#configurations)
7. [Dependencies](#dependencies)

## Overview

This MuleSoft application processes inventory data files from an SFTP server, performs data transformation and validation, and handles errors using batch processing and scheduled jobs. The application uses a combination of DataWeave transformations, SFTP operations, batch processing, and logging to manage inventory data effectively.

## Flows

### 1. `processing-flow`

- **Description**: This flow handles the core processing logic for transforming and validating inventory data.
- **Steps**:
  1. **Transform To JSON**: Converts the incoming CSV payload to JSON format.
  2. **Batch Processing**: Initiates a batch job to process records in bulk.

### 2. `real-scenario-flow`

- **Description**: This flow is scheduled to run daily and triggers the `processing-flow` to handle inventory files from a real scenario.
- **Steps**:
  1. **Scheduler**: Runs every day at 4 AM as per the cron expression.
  2. **SFTP Read**: Reads the inventory file from the SFTP server.
  3. **Flow Ref**: Calls the `processing-flow` to process the file.
  4. **SFTP Move**: Moves the processed file to a different directory.
  
### 3. `testing-flow-execution`

- **Description**: This flow is used for testing purposes and listens for new or updated CSV files in the specified directory.
- **Steps**:
  1. **SFTP Listener**: Listens for new or updated files.
  2. **Flow Ref**: Calls the `processing-flow` to process the file.

## Batch Processing

### Batch Job: `int-inventory-managementBatch_Job`

- **Description**: Processes inventory records in batches.
- **Steps**:
  1. **Discard Invalid Records**: Validates records using custom validation logic.
  2. **Batch Aggregator**: Groups valid records by `StoreId` and writes them to separate files.
  3. **Handle Invalid Records**: Aggregates invalid records and sends an error report via email.

## Error Handling

- **Try-Catch Blocks**: Used for handling errors during SFTP operations.
- **Error Propagation**: Handles illegal path errors and sends detailed error emails.

## Scheduler

- **Everyday at 4 AM**: Configured to run using a cron expression to trigger the `real-scenario-flow`.

## Configurations

- **Properties Used**:
  - `inventory-syncronization.batch-size`: Batch size for processing.
  - `inventory-syncronization.scheduler-cron`: Cron expression for scheduling.
  - `inventory-syncronization.timezone`: Timezone for the scheduler.
  - `inventory-syncronization.new-files-path`: Path to save new files.
  - `inventory-syncronization.processed-files-path`: Path to move processed files.

## Dependencies

- **MuleSoft Connectors**:
  - SFTP Connector: Used for reading from and writing to an SFTP server.
  - Email Connector: Used for sending error notifications.
  - JSON Logger Connector: Used for structured logging of flow execution.

## Conclusion

This MuleSoft application is designed to automate the process of inventory file management, ensuring efficient data synchronization and error handling. By leveraging batch processing, data validation, and scheduled jobs, it provides a robust solution for inventory data management.
