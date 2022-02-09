Demo code: 
- Call_delegatecall_staticcall/Demo.sol
- call_transfer_send/Demo.sol
- require_assert_revert/Demo.sol

Demo attack:
- Call_delegatecall_staticcall/Attack_delegatecall: lưu ý trong delegatecall
    + Attack1.sol: Lỗ hổng thứ tự cấu trúc
    + Attack2.sol: Lỗ hổng không ràng buộc khi thực hiện lời gọi
- Avoid.sol: Ngăn chặn đưa dữ liệu bí mất lên onchail
- Physing.sol: lưu ý khi sử dụng tx.origin
- Random.sol: Lỗ hổng trong random số học