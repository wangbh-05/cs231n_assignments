# 本地运行指南（Windows）

适用于本仓库 cs231n 作业在 Windows 本地环境运行，无需 Colab。

## 1. 准备 Python 环境
- 建议使用 Python 3.10 或 3.11。
- 建议为每个作业单独创建虚拟环境。

示例（PowerShell）：
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install --upgrade pip
# Assignment 1 所需最小依赖
pip install -r .\assignments\assignment1\requirements.txt
```
Assignment 2/3 依赖较多，按需要增量安装；若导出 PDF 失败，确保安装 nbconvert>=7、以及 PyPDF2（用于合并）。

## 2. 下载数据集（Windows PowerShell）
在相应作业的数据集目录执行：
```powershell
# A1
cd .\assignments\assignment1\cs231n\datasets
powershell -ExecutionPolicy Bypass -File .\get_datasets.ps1

# A2（如需）
cd ..\..\assignment2\cs231n\datasets
powershell -ExecutionPolicy Bypass -File .\get_datasets.ps1

# A3（可选）
cd ..\..\assignment3\cs231n\datasets
powershell -ExecutionPolicy Bypass -File .\get_imagenet_val.ps1
powershell -ExecutionPolicy Bypass -File .\get_coco_captioning.ps1
```

## 3. 运行 Notebooks
从仓库根目录启动 Jupyter：
```powershell
jupyter notebook
```
在浏览器中打开对应作业的 ipynb 文件。

## 4. 提交打包（Windows）
在各自作业目录执行对应的 PowerShell 脚本：
```powershell
# Assignment 1
cd .\assignments\assignment1
powershell -ExecutionPolicy Bypass -File .\collectSubmission.ps1

# Assignment 2
cd ..\assignment2
powershell -ExecutionPolicy Bypass -File .\collectSubmission.ps1

# Assignment 3
cd ..\assignment3
powershell -ExecutionPolicy Bypass -File .\collectSubmission.ps1
```
脚本会：
- 检查需要的文件是否存在
- 打包 zip（使用 Compress-Archive）
- 调用 makepdf.py 将 notebook 导出为 PDF；在无 LaTeX 情况下会尝试 webpdf 作为兜底

若导出 PDF 遇到问题：
- 方案 A：安装 LaTeX 环境（如 MiKTeX），然后使用 `pdf` 导出
- 方案 B：使用 nbconvert 的 `webpdf`（需要安装 Chromium 支持，如 `pip install pyppeteer` 或 `pip install playwright && playwright install chromium`）

## 5. Assignment 2 Cython（可选）
若要编译 im2col 的 Cython 加速：
```powershell
cd .\assignments\assignment2\cs231n
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```
需要安装 MSVC 构建工具（Visual Studio Build Tools）。

## 6. 说明
- 本次改动仅做“移植”支持，不修改或完成任何 TODO 题目逻辑。
- 脚本均为 PowerShell 版本，适配 Windows 10/11 自带 tar/Expand-Archive/Compress-Archive。
