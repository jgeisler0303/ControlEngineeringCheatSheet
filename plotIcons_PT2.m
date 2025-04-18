arrowscale= 0.3;
fs= 7;
icon_width= 2;
icon_height= 2;

name= 'PT2';
G= tf(1, [1 0.5 1]);


%% Step
[y, t]= step(G);

clf
axes('Position', [0.18 0.14 0.8 0.8])
hold on
yline(1, 'm', 'LineWidth', 0.2)
plot(t, y, 'b')

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', fs)
ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', fs)

xlim([0 t(end)])
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords(t(end)*0.9*[1 1], [0 1]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(t(end)*0.9, 0.5, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconStep_' name], '-dpdf', '-r300', '-vector')

%% Nyquist
[re, im]= nyquist(G);
re= squeeze(re);
im= squeeze(im);

clf
axes('Position', [0.1 0.1 0.85 0.8])
hold on
plot([1 1], [0 0.25], 'm', 'LineWidth', 0.2)
plot(1, 0, 'ro', 'MarkerSize', 3)
plot(re, im, 'b')
plot(0, -2, 'r*', 'MarkerSize', 3)


ylim([-2.3 0.9])
xlim([-0.8 1.5])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\textrm{Re}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [1.5 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
ylabel('$\textrm{Im}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.02 0.92], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([0 1], [0.2 0.2]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(0.5, 0.2, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.98, 0, '$\omega=0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
text(0.05, -2, '$\omega_0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom')

print(['IconNyquist_' name], '-dpdf', '-r300', '-vector')

%% Bode Amp
[A, phi, om]= bode(G*10);
A= 20*log10(squeeze(A));
phi= squeeze(phi);

clf
axes('Position', [0.2 0.1 0.78 0.8])
semilogx(om, om*0+20, 'm', 'LineWidth', 0.2)
hold on
semilogx([1 1], [0 30], 'r:', 'LineWidth', 0.2)
semilogx(om, A, 'b')
semilogx([1 om(end)], [20 20-40*log10(om(end))], 'r', 'LineWidth', 0.2)

ylim([-13 27])
xlim([om(1) om(end)*0.5])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95*0.5 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
ylabel('$|G(s)|_{\textrm{dB}}$', 'Interpreter', 'latex', 'FontSize', fs) %, 'Position', [0 0.2])

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([1 1], [0 20]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(0.2, 10, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

text(5, -10, '$-40\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
text(1, 0, '$\omega_0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconBodeA_' name], '-dpdf', '-r300', '-vector')

%% Bode phi
clf
axes('Position', [0.25 0.1 0.73 0.8])
semilogx(om, om*0-90, 'm:', 'LineWidth', 0.2)
hold on
semilogx(om, om*0-180, 'm', 'LineWidth', 0.2)
semilogx(om, phi, 'b')
semilogx([1 1], [-90 0], 'r:', 'LineWidth', 0.2)
semilogx([1*0.7 1/0.7], [-90 -90], 'r', 'LineWidth', 0.2)

ylim([-180 20])
xlim([om(1) om(end)])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$\angle G(s) / \circ$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.1 -90], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

set(gca, 'XTick', [])
set(gca, 'YTick', 0)
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(1, 0, '$\omega_0$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.1, -180, '$-180$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconBodeP_' name], '-dpdf', '-r300', '-vector')

%% Pole Zero
[p, z] = pzmap(G);

clf
axes('Position', [0.05 0.1 0.85 0.8])
hold on
plot(real(p(2))*[1 1], [0 imag(p(2))], 'r:', 'LineWidth', 0.2)
plot(real(p(2))*[0 1], imag(p(2))*[1 1], 'r:', 'LineWidth', 0.2)
plot(real(p), imag(p), 'xb')

ylim([-1.2 1.2])
xlim([-0.6 0.3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\sigma$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.2 0], 'HorizontalAlignment', 'center')
ylabel('$\textrm{j}\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0 1.2], 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(real(p(1)), -0.02, '$D\omega_0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.02, imag(p(2)), '$\omega_D$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle')

[ax, ay]= annotCoords([0 real(p(1))], [0 imag(p(1))]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(-0.11, 0.7, '$\omega_0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

print(['IconPoleZero_' name], '-dpdf', '-r300', '-vector')