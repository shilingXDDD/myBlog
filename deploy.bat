@echo off
chcp 65001
echo =======================================
echo 正在清理缓存并生成网页，请稍候...
call hexo clean
call hexo g
echo =======================================
echo 正在推送到 GitHub，准备上线！
git add .
git commit -m "auto deploy: %date% %time%"
git push origin main
echo =======================================
echo 发布完成！去 GitHub Actions 看绿勾吧！
pause