void
rotateclients(Client *head, Client *tail, int dir)
{
    Client *next;

    if (head == tail)
        return;

    if (dir < 0) {
        // rotate left
        do {
            next = nexttiled(head->next);
            swapclients(head, next);
        } while (next != tail);
    } else {
        // rotate right
        do {
            swapclients(head, tail);
            next = nexttiled(tail->next);
            tail = head;
            head = next;
        } while (next != tail);
    }
}

void
inplacerotate(const Arg *arg)
{
    int i, selidx = 0;
    Client *c, *mhead = NULL, *mtail = NULL, *shead = NULL, *stail = NULL;

    if (!selmon->sel || selmon->sel->isfloating || !selmon->lt[selmon->sellt]->arrange)
        return;

    // unhide selected client, if it was hidden
    selmon->hidsel = 0;

    for (i = 0, c = nexttiled(selmon->clients); c; c = nexttiled(c->next), i++) {
        if (c == selmon->sel)
            selidx = i;
        if (i == 0)
            mhead = c;
        if (i < selmon->nmaster)
            mtail = c;
        else if (i == selmon->nmaster)
            shead = c;
        stail = c;
    }

    if (arg->i == -2 || arg->i == 2 || !selmon->nmaster) {
        rotateclients(mhead, stail, arg->i);
    } else {
        if (selidx < selmon->nmaster)
            rotateclients(mhead, mtail, arg->i);
        else
            rotateclients(shead, stail, arg->i);
    }

    // restore focus position
    for (c = nexttiled(selmon->clients); c && selidx--; c = nexttiled(c->next));
    focus(c);
    arrange(selmon);
}
