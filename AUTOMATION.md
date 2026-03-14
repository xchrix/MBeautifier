# MBeautifier 自动化格式化指南

## 1. 安装

```matlab
addpath('/mnt/Data/A050_nav/sgal_nav_ws/MBeautifier');
```

> 建议将上述命令添加到 `startup.m` 中实现每次 MATLAB 启动自动加载。

---

## 2. 核心 API

| 方法 | 说明 |
|------|------|
| `MBeautify.formatFileNoEditor(file)` | 格式化单个文件（无编辑器） |
| `MBeautify.formatFileNoEditor(file, outFile)` | 格式化并保存到新文件 |
| `MBeautify.formatFile(file, outFile)` | 格式化并在编辑器中打开 |
| `MBeautify.formatFiles(directory, fileFilter)` | 批量格式化目录 |
| `MBeautify.formatFiles(directory, fileFilter, recurse)` | 批量格式化（递归子目录） |
| `MBeautify.formatFiles(directory, fileFilter, recurse, false)` | 批量格式化（无编辑器） |

---

## 3. 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `file` | string | - | 文件路径 |
| `outFile` | string | - | 输出文件路径（可与输入相同实现原地覆盖） |
| `directory` | string | - | 目录路径 |
| `fileFilter` | string | `'*.m'` | 文件过滤表达式 |
| `recurse` | logical | `false` | 是否递归子目录 |
| `editor` | logical | `true` | 是否使用编辑器（自动化场景设为 `false`） |

---

## 4. 使用示例

### 单文件格式化

```matlab
addpath('/mnt/Data/A050_nav/sgal_nav_ws/MBeautifier');

% 原地覆盖
MBeautify.formatFileNoEditor('test.m');

% 保存到新文件
MBeautify.formatFileNoEditor('source.m', 'dest.m');
```

### 批量格式化

```matlab
addpath('/mnt/Data/A050_nav/sgal_nav_ws/MBeautifier');

% 当前目录所有 .m 文件
MBeautify.formatFiles(pwd, '*.m');

% 递归格式化（含子目录）
MBeautify.formatFiles(pwd, '*.m', true);

% 递归格式化，无编辑器（推荐自动化使用）
MBeautify.formatFiles(pwd, '*.m', true, false);
```

### 批量格式化指定目录

```matlab
addpath('/mnt/Data/A050_nav/sgal_nav_ws/MBeautifier');

% 格式化 SINS_GNSS_LG 目录下所有 MATLAB 文件
MBeautify.formatFiles('SINS_GNSS_LG', '*.m', true, false);
```

---

## 5. 配置修改

配置文件位置：`MBeautifier/resources/settings/MBeautyConfigurationRules.xml`

### 常用配置项

```xml
<!-- 最大连续空行数 -->
<SpecialRule>
    <Key>MaximalNewLines</Key>
    <Value>2</Value>
</SpecialRule>

<!-- 矩阵添加逗号: [1 2 3] -> [1, 2, 3] -->
<SpecialRule>
    <Key>AddCommasToMatrices</Key>
    <Value>1</Value>
</SpecialRule>

<!-- 元胞数组添加逗号 -->
<SpecialRule>
    <Key>AddCommasToCellArrays</Key>
    <Value>1</Value>
</SpecialRule>

<!-- 缩进字符: white-space | tab -->
<SpecialRule>
    <Key>IndentationCharacter</Key>
    <Value>white-space</Value>
</SpecialRule>

<!-- 缩进数量 -->
<SpecialRule>
    <Key>IndentationCount</Key>
    <Value>4</Value>
</SpecialRule>

<!-- 函数体缩进策略: AllFunctions | NestedFunctions | NoIndent -->
<SpecialRule>
    <Key>Indentation_Strategy</Key>
    <Value>AllFunctions</Value>
</SpecialRule>
```

---

## 6. 代码指令（Directives）

在 MATLAB 代码中使用注释临时禁用/启用格式化：

```matlab
% 格式化这部分代码
a =  1;

% MBD:Format:Off
longVariableName = 'where the assignment is';
aligned          = 'with the next assignment';
% MBD:Format:On

% 继续格式化
someMatrix  =  [1 2 3];
```

完整格式：`% MBeautifierDirective:Format:Off`

---

## 7. 批量格式化脚本模板

创建 `format_all.m` 文件：

```matlab
function format_all(rootDir)
    % 批量格式化目录下所有 MATLAB 文件
    % 用法: format_all('SINS_GNSS_LG')

    if nargin < 1
        rootDir = pwd;
    end

    addpath('/mnt/Data/A050_nav/sgal_nav_ws/MBeautifier');

    fprintf('Formatting MATLAB files in: %s\n', rootDir);
    MBeautify.formatFiles(rootDir, '*.m', true, false);
    fprintf('Done.\n');
end
```

使用：
```matlab
format_all('SINS_GNSS_LG');
```
