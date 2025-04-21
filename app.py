import streamlit as st
import subprocess
import tempfile
import os

st.set_page_config(page_title="Language Detector", layout="centered")

st.title("🧠 Code Language Detector")
st.write("Upload a code snippet file to detect the programming language.")

uploaded_file = st.file_uploader("Choose a .txt file", type=["txt"])

if uploaded_file is not None:
    if not os.path.exists("lang_detector.exe"):
        st.error("❌ 'lang_detector.exe' not found in current directory.")
    else:
        # Save uploaded file to a temporary file
        with tempfile.NamedTemporaryFile(delete=False, suffix=".txt") as tmp_file:
            tmp_file.write(uploaded_file.read())
            tmp_path = tmp_file.name

        try:
            # Run the executable with file input
            result = subprocess.run(
                ["lang_detector.exe"],
                stdin=open(tmp_path, "r"),
                capture_output=True,
                text=True
            )
            st.subheader("🔍 Detected Language:")
            st.code(result.stdout.strip(), language='text')
        except Exception as e:
            st.error(f"Error running executable: {e}")
        finally:
            os.unlink(tmp_path)
