# OCRmyPDF Quick Install
适用于 MacOS 的 OCRmyPDF 一键安装脚本
自动下载 中/英 语言包
## Usage
### Install 
```
curl https://raw.githubusercontent.com/jsmjsm/OCRmyPDF-Quick-Install/master/quick-install-ocrmypdf.sh -o quick-install-ocrmypdf.sh && chmod 777 ./quick-install-ocrmypdf.sh && ./quick-install-ocrmypdf.sh && rm ./quick-install-ocrmypdf.sh
```
### MacOS Workflow
[Download](https://github.com/jsmjsm/OCRmyPDF-Quick-Install/blob/master/OCRmyPDF.workflow.zip)
### Demo 
![使用效果](https://raw.githubusercontent.com/jsmjsm/ocrmypdf-install/master/demo.jpg)
### Reference
OCRmyPDF 项目地址： https://github.com/jbarlow83/OCRmyPDF

### How to use
Demo
```
@ocrmypdf "$input-file-name" "$outout-file-name" -l chi_sim+eng --force-ocr
```
