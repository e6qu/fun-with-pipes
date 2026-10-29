/* snprintf is the independent decimal-formatting oracle, never a timing peer. */
static int check_unsigned(uint64_t value) {
    char text[32];
    int length = snprintf(text, sizeof text, "%" PRIu64, value);
    return length > 0 && fwp_u64_chars(value) == length;
}
static int check_signed(int64_t value) {
    char text[32];
    int length = snprintf(text, sizeof text, "%" PRId64, value);
    return length > 0 && fwp_i64_chars(value) == length;
}
int main(void) {
    for (uint64_t value = 0; value <= UINT64_C(65535); value++)
        if (!check_unsigned(value) || !check_signed((int64_t)value) ||
            !check_signed(-(int64_t)value)) return 247;
    for (unsigned bit = 0; bit < 64; bit++) {
        uint64_t power = UINT64_C(1) << bit;
        if (!check_unsigned(power - 1) || !check_unsigned(power) ||
            !check_unsigned(power + 1)) return 247;
        if (bit < 63 && (!check_signed(-(int64_t)power) ||
                        !check_signed(-(int64_t)(power + 1)))) return 247;
    }
    uint64_t power = 1;
    for (unsigned exponent = 0; exponent < 20; exponent++) {
        if (!check_unsigned(power - 1) || !check_unsigned(power) ||
            !check_unsigned(power + 1)) return 247;
        if (exponent < 19) power *= 10;
    }
    if (!check_unsigned(UINT64_MAX) || !check_signed(INT64_MIN) ||
        !check_signed(INT64_MAX)) return 247;
    /* No line ending: this standalone oracle does not install fwp binary I/O. */
    fputs("decimal length boundaries pass", stdout);
    return 0;
}
