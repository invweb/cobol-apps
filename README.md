# COBOL Applications

## Tank Game

![Tank Game](tank_screenshot.png)

### How to run Tank Game

1. **Compile:**
   ```bash
   cobc -x -o TANK TANK.COB
   ```

2. **Run:**
   ```bash
   ./TANK
   ```

### Controls
| Key | Action |
|-----|--------|
| `8` | Move Up |
| `2` | Move Down |
| `4` | Move Left |
| `6` | Move Right |
| `5` | Shoot |
| `0` | Quit |

### Legend
- `*` — Your tank
- `#` — Enemy
- `.` — Shell

---

## Calculator

### How to run Calculator

1. **Compile:**
   ```bash
   cobc -x -o CALCULATOR CALCULATOR.COB
   ```

2. **Run:**
   ```bash
   ./CALCULATOR
   ```

### Features
- Basic arithmetic: `+`, `-`, `*`, `/`
- Division by zero protection
- Loop mode (continue after each calculation)

---

## Requirements

- [GnuCOBOL](https://gnucobol.sourceforge.io/) compiler

### Install GnuCOBOL (macOS)

```bash
brew install gnucobol
```

### Install GnuCOBOL (Linux - Debian/Ubuntu)

```bash
sudo apt install gnucobol
```
