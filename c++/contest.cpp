#include <iostream>
#include <stdio.h>
#include <cmath>
#include <string>
#include <algorithm>
#include <vector>
#include <queue>

using namespace std;

vector<int> g[1000002];
int n, d[1000002];

void read() {
    cin >> n;
    for (int i = 1; i <= n; ++i) g[i].clear();
    for (int i = 1; i <= n; ++i) {
        int siz; cin >> siz;
        for (int j = 0; j < siz; ++j) {
            int x; cin >> x;
            g[i].push_back(x);
        }
    }
}

void go(int u) {
    d[u] = -1;
    if (g[u].size() == 0) d[u] = 1;
    for (int i = 0; i < g[u].size(); ++i) {
        int v = g[u][i];
        if (d[v] == 0) go(v);
        cout << v << " " << d[v] << "\n";
        if (d[v] == -1) {
            d[u] = -1;
            return;
        }

        int tmp = d[v];
        if (v > u) tmp++;
        d[u] = max(d[u], tmp);
    }
}

void sol() {
    read();
    for (int i = 0; i <= n; ++i) d[i] = 0;
    int ans = -1;
    for (int i = 1; i <=n; ++i) {
        if (d[i] == 0) go(i);

        //cout << d[i] << "\n";
        if (d[i] == -1) {
            cout << "-1\n";
            return;
        }

        ans = max(ans, d[i]);
    }
    cout << ans << "\n";
}

int main() {
    int t; cin >> t;
    for (int i = 0; i < t; ++i) {
        sol();
    }
    return 0;
}
