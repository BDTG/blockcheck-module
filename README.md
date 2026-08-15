# blockcheck-module

Module `blockcheck` cho [modular-app-framework](https://github.com/BDTG/modular-app-framework):
chạy **blockcheck2.sh** (zapret2) để dò chiến lược DPI chống chặn cho từng domain,
parse SUMMARY → danh sách strategies.

## Build

```powershell
# 1. (1 lần) Tạo NuGet local feed — chạy trong framework repo:
#    powershell -File src/scripts/publish_local_feed.ps1
# 2. Build module:
dotnet build -c Release
```

## Cấu hình (`module.json` → `config`)

| Key | Ý nghĩa |
|---|---|
| `bundlePath` | Thư mục `zapret-win-bundle` (chứa `blockcheck\zapret2\blockcheck2.sh`, `cygwin\`, `zapret-winws\`) |

## Bundle zapret2

Binaries (blockcheck2.sh, cygwin, winws2) thuộc [bol-van/zapret-win-bundle](https://github.com/bol-van/zapret-win-bundle),
**không commit** (`bundle/` gitignored). Tải về:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/download_zapret_binaries.ps1
```

## Ops (JSON-RPC qua ModuleHost)

- `blockcheck.run` `{domain, ipv4, ipv6}` — chạy blockcheck2, trả về khi xong
  (có thể mất vài phút); lỗi sạch nếu thiếu bundle
- `blockcheck.poll` — trạng thái tiến trình + số strategies tìm được
- `blockcheck.cancel` — hủy
