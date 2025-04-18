function [tu, tg, tq, hq, d]= calcWendetangente(G)
K= dcgain(G);
dG= G*tf('s');
ddG= dG*tf('s');
[~, t]= step(G);
t_end= t(end);

tq= fzero(@(t) [0 1]*lsim(ddG, [1 1], [0 t]), [eps t_end]);
hq= sum(lsim(G, [1 1], [0 tq]));
d= sum(lsim(dG, [1 1], [0 tq]));

tu= tq-hq/d;
tg= tq + (K-hq)/d - tu;

end