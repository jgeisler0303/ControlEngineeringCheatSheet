arrowscale= 0.3;
fs= 7;
icon_width= 2;
icon_height= 2;

name= 'PI';
G= 1 + tf(1, [1 0]);


%% Step
t= 0:0.01:2;
y= step(G, t)';
y= [0 y];
t= [0 t];

clf
axes('Position', [0.12 0.14 0.86 0.8])
hold on
plot([-1 0], [0 1], 'm', 'LineWidth', 0.2)
plot([0.5 1.5], [1.5 1.5], 'm', 'LineWidth', 0.2)
plot([1.5 1.5], [1.5 2.5], 'm', 'LineWidth', 0.2)
plot(t, y, 'b')


xlabel('$t$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [t(end) 0], 'HorizontalAlignment', 'right')
ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0 y(end)], 'HorizontalAlignment', 'right')

set(gca, 'YAxisLocation', 'origin')
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'XTick', 0)
set(gca, 'YTick', [])
set(gca, 'Box', 'off')
% xlim([0 2])
% ylim([0 3])

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(-1, 0, '$T_N$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(-0.05, 1, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
text(1, 1.5, '$1$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(1.55, 2, '$\frac{K_R}{T_N}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle')

print(['IconStep_' name], '-dpdf', '-r300', '-vector')

%% Nyquist
om= [1e-1 1e4];
[re, im]= nyquist(G, om);
re= squeeze(re);
im= squeeze(im);

clf
axes('Position', [0.18 0.1 0.8 0.8])
hold on
plot([1 1], [0 0.25], 'm', 'LineWidth', 0.2)
plot(1, 0, 'rx', 'MarkerSize', 3)
plot(re, im, 'b')

ylim([-1 0.3])
xlim([0 1.3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\textrm{Re}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [1.3 0.0], 'HorizontalAlignment', 'right')
ylabel('$\textrm{Im}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0 0.3], 'HorizontalAlignment', 'right')

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([0 1], [0.2 0.2]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(0.5, 0.2, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.9, -0.1, '$\omega=\infty$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', 45)

print(['IconNyquist_' name], '-dpdf', '-r300', '-vector')

%% Bode Amp
[A, phi, om]= bode(G*10);
A= 20*log10(squeeze(A));
phi= squeeze(phi);

clf
axes('Position', [0.2 0.16 0.78 0.78])
semilogx(om, om*0+20, 'm', 'LineWidth', 0.2)
hold on
semilogx([1 1], [0 20], 'r:', 'LineWidth', 0.2)
semilogx(om, A, 'b')
semilogx([om(1) 1], [A(1) 20], 'r', 'LineWidth', 0.2)

ylim([0 60])
% xlim([0 1])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$|G(s)|_{\textrm{dB}}$', 'Interpreter', 'latex', 'FontSize', fs) %, 'Position', [0 0.2])

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([95 95], [0 20]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(50, 10, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

text(.03, 55, '$-20\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle')
text(1, 0, '$1/T_N$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconBodeA_' name], '-dpdf', '-r300', '-vector')

%% Bode phi
clf
axes('Position', [0.2 0.1 0.78 0.8])
semilogx(om, om*0-90, 'm', 'LineWidth', 0.2)
hold on
semilogx(om, phi, 'b')
semilogx([1 1], [-55 0], 'r:', 'LineWidth', 0.2)
semilogx([1*0.7 1/0.7], -[45 45], 'r', 'LineWidth', 0.2)

ylim([-90 20])
% xlim([0 1])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
ylabel('$\angle G(s) / \circ$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.01 -45], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

set(gca, 'XTick', [])
set(gca, 'YTick', 0)
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(1, 0, '$1/T_N$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.01, -90, '$-90$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconBodeP_' name], '-dpdf', '-r300', '-vector')

%% Pole Zero
[p, z] = pzmap(G);

clf
axes('Position', [0.05 0.1 0.85 0.8])
plot([-1 -1], [0.05 0.5], 'm', 'LineWidth', 0.2)
hold on
plot(real(p), imag(p), 'xb')
plot(real(z), imag(z), 'ob')

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
text(-0.5, 0.4, '$1/T_N$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

print(['IconPoleZero_' name], '-dpdf', '-r300', '-vector')