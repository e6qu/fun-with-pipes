/* Frozen text behavior from a948b7478278; kept as an independent oracle. */
static void baseline_format_g(char *out, size_t cap, double x, int p) {
    char sci[64];
    snprintf(sci, sizeof sci, "%.*e", p - 1, x);
    char *e = strchr(sci, 'e');
    int exp = atoi(e + 1);
    if (exp < -5 || exp > 16) {
        char mant[64];
        size_t ml = (size_t)(e - sci);
        memcpy(mant, sci, ml);
        mant[ml] = 0;
        if (strchr(mant, '.')) {
            while (ml > 0 && mant[ml - 1] == '0') mant[--ml] = 0;
            if (ml > 0 && mant[ml - 1] == '.') mant[--ml] = 0;
        }
        snprintf(out, cap, "%se%c%02d", mant, exp < 0 ? '-' : '+', exp < 0 ? -exp : exp);
    } else {
        int decimals = p - 1 - exp;
        if (decimals < 0) decimals = 0;
        snprintf(out, cap, "%.*f", decimals, x);
        size_t l = strlen(out);
        if (strchr(out, '.')) {
            while (l > 0 && out[l - 1] == '0') out[--l] = 0;
            if (l > 0 && out[l - 1] == '.') out[--l] = 0;
        }
    }
}

static void baseline_finish_float(char *s) {
    if (!strchr(s, '.') && !strchr(s, 'e') && !strstr(s, "inf") && !strstr(s, "NaN"))
        strcat(s, ".0");
}

static void baseline_fmt_f64(char *out, double x) {
    if (isnan(x)) { strcpy(out, "NaN"); return; }
    if (isinf(x)) { strcpy(out, x > 0 ? "inf" : "-inf"); return; }
    for (int p = 1; p <= 17; p++) {
        baseline_format_g(out, 400, x, p);
        if (strtod(out, 0) == x) { baseline_finish_float(out); return; }
    }
    baseline_format_g(out, 400, x, 17);
    baseline_finish_float(out);
}

static void baseline_fmt_f32(char *out, float x) {
    if (isnan(x)) { strcpy(out, "NaN"); return; }
    if (isinf(x)) { strcpy(out, x > 0 ? "inf" : "-inf"); return; }
    for (int p = 1; p <= 9; p++) {
        baseline_format_g(out, 400, (double)x, p);
        if (strtof(out, 0) == x) { baseline_finish_float(out); return; }
    }
    baseline_format_g(out, 400, (double)x, 9);
    baseline_finish_float(out);
}

