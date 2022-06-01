# 在 Markdown 中编写 Latex 语法

## 基本格式

Markdown 中编写 LaTex 公式有两种方式：

- 行内公式：\$ ... \$
- 行间公式：\$\$ ... \$\$

  例如：

  - 行内公式：$E=mc$
  - 行间公式：
    $$
    \sum_{i=0}^N\int_{a}^{b}g(t,i)\text{d}t
    $$

## 常用字母显示

### 希腊字母

> 若需要大写希腊字母，将命令的首字母大写即可。比如$\alpha$(`$\alpha$`)的大写为$\Alpha$(`$\Alpha$`)

| 显示       | 命令     | 显示     | 命令   | 显示       | 命令     |
| ---------- | -------- | -------- | ------ | ---------- | -------- |
| $\alpha$   | \alpha   | $\beta$  | \beta  | $\omega$   | \omega   |
| $\gamma$   | \gamma   | $\delta$ | \delta | $\psi$     | \psi     |
| $\epsilon$ | \epsilon | $\zeta$  | \zeta  | $\chi$     | \chi     |
| $\eta$     | \eta     | $\theta$ | \theta | $\phi$     | \phi     |
| $\iota$    | \iota    | $\theta$ | \theta | $\upsilon$ | \upsilon |
| $\lambda$  | \lambda  | $\mu$    | \mu    | $\tau$     | \tau     |
| $\nu$      | \nu      | $\xi$    | \xi    | $\sigma$   | \sigma   |
| $\pi$      | \pi      | $\rho$   | \rho   |

### 字母修饰

#### 上下标

- 上标： ^

    `$x^3+x^9$` 显示为$x^3+x^9$

- 下标： _ 

    `$C_n^2$` 显示为$C_n^2$

#### 矢量

`$\vec a$`显示为$\vec a$

### 运算

#### 分数

`$\frac{分子}{分母}$`产生一个分数，分数可嵌套。便捷情况下可以输入`$\frac ab$`来快速生成一个$\frac ab$ 。

`$\frac{a-1}{b-1}$`显示为 $\frac{a-1}{b-1}$ 。
























