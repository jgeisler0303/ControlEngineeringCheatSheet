arrowscale= 0.3;
fs= 7;
icon_width= 2;
icon_height= 2;

name= 'PT1x2';
Ga= tf(1, [1 1])*tf(1, [1 1])*tf(1, [1 1]);
Gb= tf(1, [1 1])*tf(1, [1 1]);
Gc= tf(1, [1 1])*tf(1, [100 1]);


%% Step
[y, t]= step(Ga);
[tu, tg, tq, hq, d]= calcWendetangente(Ga);

clf
axes('Position', [0.18 0.14 0.8 0.8])
hold on
yline(1, 'm', 'LineWidth', 0.2)
plot([0 3], [0 0], 'r')
plot(t, y, 'b')
plot([tu tu+tg], [0 1], 'm', 'LineWidth', 0.2)

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', fs)
ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', fs)

xlim([0 t(end)])
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([8 8], [0 1]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(8-0.3, 0.5, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconStep_' name], '-dpdf', '-r300', '-vector')

%% Nyquist
[re, im]= nyquist(Gb);
re= squeeze(re);
im= squeeze(im);

clf
axes('Position', [0.1 0.1 0.85 0.8])
hold on
plot([1 1], [0 0.25], 'm', 'LineWidth', 0.2)
plot(1, 0, 'ro', 'MarkerSize', 3)
plot(re, im, 'b')

ylim([-0.7 0.4])
xlim([-0.2 1])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\textrm{Re}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.95 0.17], 'HorizontalAlignment', 'right')
ylabel('$\textrm{Im}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.02 0.42], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([0 1], [0.2 0.2]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(0.5, 0.2, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.98, 0, '$\omega=0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')

print(['IconNyquist_' name], '-dpdf', '-r300', '-vector')

%% Bode Amp
[A, phi, om]= bode(Gc*1000);
A= 20*log10(squeeze(A));
phi= squeeze(phi);

clf
axes('Position', [0.2 0.1 0.78 0.8])
semilogx(om, om*0+60, 'm', 'LineWidth', 0.2)
hold on
semilogx([1 1], [0 30], 'r:', 'LineWidth', 0.2)
semilogx(0.01*[1 1], [0 60], 'r:', 'LineWidth', 0.2)
semilogx(om, A, 'b')
semilogx([0.01 om(end)], [60 60-20*(log10(om(end))-log10(0.01))], 'r', 'LineWidth', 0.2)
semilogx([0.3 om(end)], [20+40*log10(1/0.3) 20-40*(log10(om(end))-log10(1))], 'r', 'LineWidth', 0.2)

ylim([-80 20]+40)
xlim([om(1) om(end)*0.4])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95*0.4 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
ylabel('$|G(s)|_{\textrm{dB}}$', 'Interpreter', 'latex', 'FontSize', fs) %, 'Position', [0 0.2])

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([7 7], [0 60]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(0.0009, 30, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

text(0.05, 55, '$-20\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top')
text(12, -25, '$-40\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
text(0.01, -3, '$1/T_1$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(1, -3, '$1/T_2$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconBodeA_' name], '-dpdf', '-r300', '-vector')

%% Bode phi
clf
axes('Position', [0.25 0.1 0.73 0.8])
semilogx(om, om*0-90, 'm:', 'LineWidth', 0.2)
hold on
semilogx(om, om*0-45, 'm:', 'LineWidth', 0.2)
semilogx(om, om*0-135, 'm:', 'LineWidth', 0.2)
semilogx(om, om*0-180, 'm', 'LineWidth', 0.2)
semilogx(om, phi, 'b')
semilogx([1 1], [-55-90 0], 'r:', 'LineWidth', 0.2)
semilogx([1*0.7 1/0.7], [-135 -135], 'r', 'LineWidth', 0.2)
semilogx([0.01 0.01], [-55 0], 'r:', 'LineWidth', 0.2)
semilogx([0.01*0.7 0.01/0.7], [-45 -45], 'r', 'LineWidth', 0.2)

ylim([-180 20])
xlim([om(1) om(end)])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$\angle G(s) / \circ$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.0001 -90], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

set(gca, 'XTick', [])
set(gca, 'YTick', 0)
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(1, 0, '$1/T_2$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.01, 0, '$1/T_1$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.0001, -180, '$-180$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconBodeP_' name], '-dpdf', '-r300', '-vector')

%% Pole Zero
Gd= tf(1, [1 1])*tf(1, [0.55 1]);
[p, z] = pzmap(Gd);

clf
axes('Position', [0.05 0.1 0.85 0.8])
plot([-1 -1], [0.05 0.5], 'm', 'LineWidth', 0.2)
hold on
plot([-1/0.55 -1/0.55], -[0.05 0.5], 'm', 'LineWidth', 0.2)
plot(real(p), imag(p), 'xb')

ylim([-1 1])
xlim([-2 0.3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\sigma$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.2 0], 'HorizontalAlignment', 'center')
ylabel('$\textrm{j}\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0 1], 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([-1 0], [0.4 0.4]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(-0.5, 0.4, '$1/T_2$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

[ax, ay]= annotCoords([-1/0.55 0], -[0.4 0.4]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(-1/0.55/2, -0.4, '$1/T_1$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconPoleZero_' name], '-dpdf', '-r300', '-vector')