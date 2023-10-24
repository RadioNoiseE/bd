open Https;;

print_string (Https.request "https://api.bilibili.com/x/player/playurl?avid=99999999&cid=171776208&qn=112&fnval=0&fnver=0&fourk=1" "https://www.bilibili.com/video/av99999999/"  "SESSDATA=697eb448%2C1713574556%2C09ce6%2Aa2CjAb9BRaEPncAt5FpUqMSNBZn8hsyh068l_-IoOEWDXP9p3jgcTUyI7IuwkytTFq490SVjdOeTc4WkViVjh3Q2RtdU9CSWRQSDJqalBfT3UxOUNBLTlWd0dNcmVVVlNmX0xGMlZhTy1LdG1tTFpkZ1RETFA2cHRMM1NDV1BxS2JPY050M3puODdRIIEC");
