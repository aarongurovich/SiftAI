# Sift AI

Sift AI is an AI-powered platform for statistical analysis and data visualization of structured files (CSV, XLS, XLSX). It leverages Google's Gemini models to generate Python code for data analysis, executing it securely within a Pyodide sandbox to provide charts, tables, and insights.

## Getting Started

Follow these steps to set up the project locally.

### Prerequisites

* **Python** (v3.11 or higher recommended)
* **Node.js** (LTS version, v18+)
* **Doppler** (Optional, for secrets management)
* **Google Cloud API Key** (for Gemini AI access)

### Installation

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/aarongurovich/siftai.git](https://github.com/aarongurovich/siftai.git)
    cd siftai
    ```

2.  **Install Node.js dependencies**
    ```bash
    npm install
    ```
    *This installs packages like `@google/generative-ai` and `pyodide` required for the chatbot engine.*

3.  **Install Python dependencies**
    ```bash
    pip install -r requirements.txt
    ```
    *This installs FastAPI, Pandas, Matplotlib, and other analysis tools.*

4.  **Configure Environment**
    Create a `.env` file in the root directory and add your API key:
    ```bash
    GOOGLE_API_KEY=your_key_here
    ```
    *Alternatively, use `doppler setup` if you prefer Doppler for secrets management.*

5.  **Start the application server**
    ```bash
    uvicorn main:app --reload --host 0.0.0.0 --port 8000
    ```
    *If using Doppler:*
    ```bash
    doppler run -- uvicorn main:app --reload --host 0.0.0.0 --port 8000
    ```

6.  Open your browser and navigate to `http://localhost:8000` to view the site.

## Available Scripts

* `uvicorn main:app`: Starts the FastAPI backend server which handles file uploads and workspace management.
* `node chatbot.js <file> "<question>"`: The core CLI tool that interfaces with Gemini to generate analysis plans and execute them in a Pyodide sandbox.
* `python demo.py`: Runs a demonstration script to test the chatbot pipeline programmatically without the web UI.
* `docker build .`: Builds the container image using the provided `Dockerfile`.

## Customization

### Application Structure
The project uses a lightweight structure:
* **Frontend**: `index.html` contains the entire UI, using Tailwind CSS (via CDN) for styling and Plotly.js for interactive charts.
* **Backend**: `main.py` manages file uploads, creates isolated workspaces, and delegates analysis tasks to the Node.js runner.
* **AI Engine**: `chatbot.js` is the bridge between the backend and the LLM, handling prompt engineering and code execution.

### AI Configuration
To modify how the AI analyzes data:
* **Prompts**: Edit `chatbot.js` to adjust the `SYSTEM_RULES` or model parameters (currently defaults to `gemini-2.5-flash`).
* **Sandbox**: The project uses Pyodide for safe code execution. You can modify `chatbot.js` to pre-load different Python libraries if needed.

## Author

**Aaron Gurovich**
